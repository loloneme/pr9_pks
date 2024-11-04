package handler

import (
	"github.com/gin-gonic/gin"
	"github.com/loloneme/pr9/backend/internal/service"
)

type Handler struct {
	services *service.Service
}

func NewHandler(services *service.Service) *Handler {
	return &Handler{services: services}
}

func (h *Handler) InitRoutes() *gin.Engine {
	router := gin.New()

	router.Use(gin.Logger())
	api := router.Group("/handler")
	{
		drink := api.Group("/drink")
		{
			drink.GET("/all", h.GetAllDrinks)
			drink.GET("/:id", h.GetDrinkByID)

			drink.PATCH("/:id", h.ToggleFavorite)
			drink.PUT("/:id", h.UpdateDrink)

			drink.POST("", h.CreateDrink)
			drink.DELETE("/:id", h.DeleteDrink)
		}
	}

	return router
}
