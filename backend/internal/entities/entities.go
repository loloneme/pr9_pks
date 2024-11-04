package entities

type Drink struct {
	ID          int64    `json:"drink_id"`
	Name        string   `json:"name"`
	ImageURL    string   `json:"image"`
	Description string   `json:"description"`
	Compound    []string `json:"compound"`

	Cold       bool           `json:"is_cold"`
	Hot        bool           `json:"is_hot"`
	Prices     map[string]int `json:"prices"`
	IsFavorite bool           `json:"is_favorite"`
}
