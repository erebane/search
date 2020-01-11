package search

import (
	"context"
	"fmt"
	"log"

	elastic "github.com/olivere/elastic"

	//"github.com/davecgh/go-spew/spew"
	"encoding/json"
	"io/ioutil"
	"os"
	//"bytes"
	//"reflect"
)

const esHost string = "http://shontaya-ashburn.perneka.hajaan.nu:9200"

type Events struct {
	Data []Event `json:"data"`
}
type Event struct {
	Text        string `json:"text"`
	User        string `json:"user"`
	Context     string `json:"context"`
	Description string `json:"description"`
}

type Wekan struct {
	Text        string `json:"text"`
	CardID      string `json:"cardId"`
	ListID      string `json:"listId"`
	BoardID     string `json:"boardId"`
	User        string `json:"user"`
	Card        string `json:"card"`
	Description string `json:"description"`
}

type SearchHandler struct {
	client *elastic.Client
}
type DataFlowSearchResult struct {
	DocCountErrorUpperBound int `json:"doc_count_error_upper_bound"`
	SumOtherDocCount        int `json:"sum_other_doc_count"`
	Buckets                 []struct {
		Num1 struct {
			Value json.Number `json:"value"`
		} `json:"1"`
		Num4 struct {
			DocCountErrorUpperBound int `json:"doc_count_error_upper_bound"`
			SumOtherDocCount        int `json:"sum_other_doc_count"`
			Buckets                 []struct {
				Num1 struct {
					Value json.Number `json:"value"`
				} `json:"1"`
				Num2 struct {
					Value json.Number `json:"value"`
				} `json:"2"`
				Key      string `json:"key"`
				DocCount int    `json:"doc_count"`
			} `json:"buckets"`
		} `json:"4"`
		Key      string `json:"key"`
		DocCount int    `json:"doc_count"`
	} `json:"buckets"`
}

type DataFlow struct {
	SourceIps []Source
}
type Source struct {
	IP           string
	Destinations []Destination
}

type Destination struct {
	IP       string
	Transmit json.Number //`json:"transmitPerIp"`
	Receive  json.Number //`json:"receivePerIp"`
}

func CreateSearchHandler() SearchHandler {
	// Create a client
	client, err := elastic.NewClient(elastic.SetURL(esHost))
	if err != nil {
		fmt.Println(esHost)
		log.Fatal("Client failed: ", err)
	}

	// Ping Elasticsearch server to get e.g. the version number
	info, code, err := client.Ping(esHost).Do(context.Background())
	if err != nil {
		// Handle error
		panic(err)
	}
	fmt.Println("Response code: ", code)
	fmt.Println("Version: ", info.Version.Number)

	return SearchHandler{
		client: client,
	}
}

func GetDataFlows() (dataFlow DataFlow) {
	searchHandler := CreateSearchHandler()
	client := searchHandler.client

	file, e := ioutil.ReadFile("/opt/search/assets/packetbeat/netflow.json")
	if e != nil {
		fmt.Printf("File error: %v\n", e)
		os.Exit(1)
	}

	search := elastic.NewSearchService(client).Source(string(file))
	res, err := search.Do(context.TODO())
	if err != nil {
		// Handle error
		panic(err)
	}
	var flowResult DataFlowSearchResult
	json.Unmarshal(res.Aggregations["3"], &flowResult)
	for _, ipBucket := range flowResult.Buckets {
		source := Source{
			IP: ipBucket.Key,
		}
		for _, destBucket := range ipBucket.Num4.Buckets {
			destination := Destination{
				IP:       destBucket.Key,
				Transmit: destBucket.Num1.Value,
				Receive:  destBucket.Num2.Value,
			}
			source.Destinations = append(source.Destinations, destination)
		}
		dataFlow.SourceIps = append(dataFlow.SourceIps, source)
	}
	return
}
func AddWekanEvent(wekan Wekan) {
	searchHandler := CreateSearchHandler()
	client := searchHandler.client
	_, err := client.Index().
		Index("events").
		Type("doc").
		BodyJson(wekan).
		Refresh("wait_for").
		Do(context.Background())
	if err != nil {
		// Handle error
		panic(err)
	}
}

func GetEvents() (events Events) {
	searchHandler := CreateSearchHandler()
	client := searchHandler.client

	searchResult, err := client.Search().
		Index("events").
		From(0).Size(100).
		Pretty(true).
		Do(context.Background())
	if err != nil {
		// Handle error
	}
	if searchResult.TotalHits() > 0 {
		// Iterate through results
		for _, hit := range searchResult.Hits.Hits {
			// Deserialize hit.Source into a Wekan struct
			var t Wekan
			err := json.Unmarshal(hit.Source, &t)
			if err != nil {
				// Deserialization failed
			}
			// Take wekan event fields to generic event
			event := Event{
				Text:        t.Text,
				User:        t.User,
				Context:     t.Card,
				Description: t.Description,
			}
			// hit.Index contains the name of the index
			events.Data = append(events.Data, event)
		}
	} else {
		// No hits
		fmt.Print("Found no events\n")
	}
	return
}
