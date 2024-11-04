package service

import (
	"github.com/loloneme/pr9/backend/internal/entities"
	"github.com/loloneme/pr9/backend/internal/repository"
)

type DrinkService struct {
	repo repository.Drink
}

func NewDrinkService(repo repository.Drink) *DrinkService {
	return &DrinkService{
		repo: repo,
	}
}

func (s *DrinkService) CreateDrink(drink *entities.Drink) (int64, error) {
	return s.repo.CreateDrink(drink)
}

func (s *DrinkService) GetDrinkByID(drinkID int64) (*entities.Drink, error) {
	return s.repo.GetDrinkByID(drinkID)
}

func (s *DrinkService) GetDrinks() ([]*entities.Drink, error) {
	return s.repo.GetDrinks()
}

func (s *DrinkService) DeleteDrink(drinkID int64) error {
	return s.repo.DeleteDrink(drinkID)
}

func (s *DrinkService) UpdateDrink(drink *entities.Drink) error {
	return s.repo.UpdateDrink(drink)
}

func (s *DrinkService) ToggleFavorite(drinkID int64) error {
	return s.repo.ToggleFavorite(drinkID)
}
