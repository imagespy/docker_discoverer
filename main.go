package main

import (
	"context"
	"flag"
	"fmt"
	"time"

	"github.com/docker/distribution/reference"
	"github.com/docker/docker/api/types"
	"github.com/docker/docker/client"
	"github.com/imagespy/imagespy/discovery"
	log "github.com/sirupsen/logrus"
)

const (
	inputName = "docker"
)

var (
	discoveryInterval = flag.Duration("discovery.interval", 1*time.Minute, "Interval at which to query the Docker daemon")
	discoveryOutput   = flag.String("discovery.output", "", "Path to file to write discovered data")
	logLevel          = flag.String("log.level", "warn", "Set log level")
)

type Discoverer struct {
	c *client.Client
}

func (d *Discoverer) Discover() (*discovery.Input, error) {
	imageIDToImage, err := d.mapImagesToIDs()
	if err != nil {
		return nil, err
	}

	containers, err := d.c.ContainerList(context.Background(), types.ContainerListOptions{})
	if err != nil {
		return nil, fmt.Errorf("list containers: %w", err)
	}

	result := &discovery.Input{Name: inputName}
	for _, c := range containers {
		image, ok := imageIDToImage[c.ImageID]
		if !ok {
			panic(fmt.Errorf("image with ID %s not in map", c.ImageID))
		}

		digestRef, _ := reference.ParseNormalizedNamed(image.RepoDigests[0])
		tagRef, _ := reference.ParseNormalizedNamed(c.Image)

		result.Images = append(result.Images, &discovery.Image{
			Digest:     digestRef.(reference.Canonical).Digest().String(),
			Repository: fmt.Sprintf("%s/%s", reference.Domain(tagRef), reference.Path(tagRef)),
			Source:     c.Names[0][1:],
			Tag:        tagRef.(reference.Tagged).Tag(),
		})
	}

	return result, nil
}

func (d *Discoverer) mapImagesToIDs() (map[string]types.ImageSummary, error) {
	images, err := d.c.ImageList(context.Background(), types.ImageListOptions{})
	if err != nil {
		return nil, fmt.Errorf("list images: %w", err)
	}

	result := map[string]types.ImageSummary{}
	for _, i := range images {
		result[i.ID] = i
	}

	return result, nil
}

func main() {
	flag.Parse()
	lvl, err := log.ParseLevel(*logLevel)
	if err != nil {
		log.Fatalf("parse log level: %w", err)
	}

	log.SetLevel(lvl)
	cli, err := client.NewClientWithOpts(client.FromEnv)
	if err != nil {
		log.Fatalf("initialize docker client: %w", err)
	}

	log.Info("Starting Docker Discoverer")
	d := &Discoverer{c: cli}
	discovery.Log(log.StandardLogger())
	log.Fatal(discovery.Run(d, *discoveryInterval, *discoveryOutput))
}
