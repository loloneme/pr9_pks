package main

import (
	"fmt"
	"github.com/ilyakaznacheev/cleanenv"
	"github.com/joho/godotenv"
	"github.com/loloneme/pr9/backend"
	"github.com/loloneme/pr9/backend/internal/handler"
	"github.com/loloneme/pr9/backend/internal/logger"
	"github.com/loloneme/pr9/backend/internal/repository"
	"github.com/loloneme/pr9/backend/internal/service"
	"log/slog"
	"os"
)

type Config struct {
	HTTPServer backend.Config
}

func main() {
	logger.InitLogger(slog.LevelDebug)
	logger.Logger.Info("Logger initialized")

	currDir, err := os.Getwd()
	if err != nil {
		logger.Logger.Error("Failed to find current dir")
		return
	}

	err = godotenv.Load(fmt.Sprintf("%s/.env", currDir))
	if err != nil {
		logger.Logger.Error("Failed to find current directory", "error", err)
		return
	}

	var cfg Config
	if err := cleanenv.ReadEnv(&cfg); err != nil {
		logger.Logger.Error("Failed to read environment variables", "error", err)
		return
	}

	db := repository.ConnectToStorage()

	repos := repository.NewRepository(db)
	services := service.NewService(repos)
	handlers := handler.NewHandler(services)

	srv := new(backend.Server)
	if err := srv.Run(cfg.HTTPServer, handlers.InitRoutes()); err != nil {
		logger.Logger.Error("Failed to connect to server", "error", err)
		return
	}
}
