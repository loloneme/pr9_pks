package repository

import (
	"fmt"
	"github.com/loloneme/pr9/backend/internal/entities"
	"github.com/loloneme/pr9/backend/internal/utils"
)

type DrinkRepo struct {
	storage *Storage
}

func NewDrinkRepo(storage *Storage) *DrinkRepo {
	return &DrinkRepo{storage: storage}
}

func (r *DrinkRepo) CreateDrink(drink *entities.Drink) (int64, error) {
	drink.ID = utils.MaxKey(r.storage.Drinks) + 1
	r.storage.Drinks[drink.ID] = drink
	return drink.ID, nil
}

func (r *DrinkRepo) GetDrinkByID(drinkID int64) (*entities.Drink, error) {
	var res *entities.Drink

	if val, ok := r.storage.Drinks[drinkID]; ok {
		return val, nil
	}

	return res, fmt.Errorf("drink not found")
}

func (r *DrinkRepo) GetDrinks() ([]*entities.Drink, error) {
	drinks := make([]*entities.Drink, 0, len(r.storage.Drinks))
	for _, drink := range r.storage.Drinks {
		drinks = append(drinks, drink)
	}
	return drinks, nil
}

func (r *DrinkRepo) DeleteDrink(drinkID int64) error {
	if _, ok := r.storage.Drinks[drinkID]; ok {
		delete(r.storage.Drinks, drinkID)
		return nil
	}

	return fmt.Errorf("drink not found")
}

func (r *DrinkRepo) UpdateDrink(drink *entities.Drink) error {
	if _, ok := r.storage.Drinks[drink.ID]; ok {
		r.storage.Drinks[drink.ID] = drink
		return nil
	}

	return fmt.Errorf("drink not found")
}

func (r *DrinkRepo) ToggleFavorite(drinkID int64) error {
	if _, ok := r.storage.Drinks[drinkID]; ok {
		r.storage.Drinks[drinkID].IsFavorite = !r.storage.Drinks[drinkID].IsFavorite
		return nil
	}

	return fmt.Errorf("drink not found")
}
