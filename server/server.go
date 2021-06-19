package server

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func Run(){
	r := gin.Default()
	r.GET("/ping", getStatus)
	err := r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
	if err != nil {
		panic("Cannot start server")
	}
}

func getStatus(c *gin.Context) {
	c.String(http.StatusOK, "pong")
}
