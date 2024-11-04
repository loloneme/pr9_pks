package service

import (
	"github.com/loloneme/pr9/backend/internal/entities"
	"github.com/loloneme/pr9/backend/internal/repository"
)

type Service struct {
	Drink
}

type Drink interface {
	CreateDrink(drink *entities.Drink) (int64, error)

	GetDrinkByID(drinkID int64) (*entities.Drink, error)
	GetDrinks() ([]*entities.Drink, error)

	UpdateDrink(drink *entities.Drink) error
	ToggleFavorite(drinkID int64) error

	DeleteDrink(drinkID int64) error
}

func NewService(repos *repository.Repository) *Service {
	return &Service{
		Drink: NewDrinkService(repos.Drink),
	}
}
