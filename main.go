package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)

// Product представляет продукт
type Product struct {
	ID             int
	Title          string
	ImageURL       string
	Name           string
	Price          float64
	Description    string
	Specifications string
	Quantity       int
	IsFavorite     bool
	InCart         bool
}

// Пример списка продуктов
var products = []Product{
	{ID: 1,
	 Title: "Venum Elite Helmet Khaki",
	 ImageURL: "https://mmawear.ru/image/catalog/Products/venum-kask-bokserski-elite-khaki.jpg",
	 Name: "Venum Elite Helmet Khaki",
	 Price: 10500,
	 Description: "Чтобы обеспечить защиту высочайшего качества, головной убор Elite изготовлен из полукожи, чтобы обеспечить комфорт во время ожидаемых интенсивных ударов по голове во время тренировки после тренировки.Головной убор Elite, хорошо известный своей прочностью, оснащен пеной тройной плотности для лучшего контроля ударов и амортизации.",
	 Specifications: "MMA",
	 Quantity: 0},
	{ID: 2,
	 Title: "Venum Elite Helmet Black Camouflage",
	 ImageURL: "https://mmawear.ru/image/cache/catalog/mmaniak/product-7628-1000x1000.jpg",
	 Name: "Venum Elite Helmet Black Camouflage",
	 Price: 9500,
	 Description: "Изготовлен из скинтекс - синтетической кожи высочайшего качества. Пена тройной плотности для поглощения ударов. Вертикальные и горизонтальные липучки обеспечивают идеальную посадку.",
	 Specifications: "MMA",
	 Quantity: 0},
	{ID: 3,
	 Title: "Venum Elite Helmet White'n'Black",
	 ImageURL: "https://mmawear.ru/image/cache/catalog/Products/venum-kask-bokserski-elite-czarnybialy-1000x1000.jpg",
	 Name: "Venum Elite Helmet White'n'Black",
	 Price: 8500,
	 Description: "Усиленный чехол для ушей. Дизайн с открытым верхом и сеткой для лучшего отвода пота и влаги. Гибкая двусторонняя застежка на липучке для индивидуальной нескользящей посадки. Ручная работа в Таиланде.",
	 Specifications: "MMA",
	 Quantity: 0},
	{ID: 4,
	Title: "Shingards VENUM Elite KHAKI/BLACK",
	ImageURL: "https://octagon-shop.com/upload/iblock/c5f/shchitki_venum_elite_standup_shinguards_khaki_black.jpg",
	Name: "Shingards VENUM Elite Khaki/Black",
	Price: 17770,
	Description: "Шингарды (накладки на ноги) Venum Elite Khaki/Black. Надежно защищают и голень, и стопу. А легендарными они стали из-за высокого коэффициента поглощения, лёгкости и удобной посадки. Шингарды предназначены для сильной работы ногами, поэтому они пользуются популярностью у бойцов тайского бокса и K-1.",
	Specifications: "MMA",
	Quantity: 0},
	{ID: 5,
	Title: "Shingards VENUM Elite BLACK/WHITE",
	ImageURL: "https://sparta-outfit.ru/wa-data/public/shop/products/76/13/1376/images/4979/4979.750x0.jpg",
	Name: "Shingards VENUM Elite BLACK/WHITE",
	Price: 17770,
	Description: "Шингарды (накладки на ноги) Venum Elite Khaki/Black. Надежно защищают и голень, и стопу. А легендарными они стали из-за высокого коэффициента поглощения, лёгкости и удобной посадки. Шингарды предназначены для сильной работы ногами, поэтому они пользуются популярностью у бойцов тайского бокса и K-1.",
	Specifications: "MMA",
	Quantity: 0},
}

// обработчик для GET-запроса, возвращает список продуктов
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	// Преобразуем список заметок в JSON
	json.NewEncoder(w).Encode(products)
}

// обработчик для POST-запроса, добавляет продукт
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		fmt.Println("Error decoding request body:", err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Printf("Received new Product: %+v\n", newProduct)
	var lastID int = len(products)

	for _, productItem := range products {
		if productItem.ID > lastID {
			lastID = productItem.ID
		}
	}
	newProduct.ID = lastID + 1
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

//Добавление маршрута для получения одного продукта

func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, Product := range products {
		if Product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(Product)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// удаление продукта по id
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем и удаляем продукт с данным ID
	for i, Product := range products {
		if Product.ID == id {
			// Удаляем продукт из среза
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent) // Успешное удаление, нет содержимого
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление продукта по id
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Ищем продукт для обновления
	for i, Product := range products {
		if Product.ID == id {

			products[i].Title = updatedProduct.Title
			products[i].ImageURL = updatedProduct.ImageURL
			products[i].Name = updatedProduct.Name
			products[i].Price = updatedProduct.Price
			products[i].Description = updatedProduct.Description
			products[i].Specifications = updatedProduct.Specifications
			products[i].Quantity = updatedProduct.Quantity

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление количества товара по ID
func updateProductQuantityHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/products/quantity/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённое количество
	var updatedQuantity struct {
		Quantity int `json:"quantity"`
	}
	err = json.NewDecoder(r.Body).Decode(&updatedQuantity)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	// Ищем продукт для обновления
	for i, product := range products {
		if product.ID == id {
			products[i].Quantity = updatedQuantity.Quantity
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Добавление или удаление товара из избранного
func toggleFavoriteHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/products/favorite/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт
	for i, product := range products {
		if product.ID == id {
			// Переключаем статус избранного
			products[i].IsFavorite = !products[i].IsFavorite
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление флага InCart (добавление/удаление из корзины)
func toggleCartHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/products/cart/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт
	for i, product := range products {
		if product.ID == id {
			// Переключаем статус InCart
			products[i].InCart = !products[i].InCart
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)                     // Получить все продукты
	http.HandleFunc("/products/create", createProductHandler)            // Создать продукт
	http.HandleFunc("/products/", getProductByIDHandler)                 // Получить продукт по ID
	http.HandleFunc("/products/update/", updateProductHandler)           // Обновить продукт
	http.HandleFunc("/products/delete/", deleteProductHandler)           // Удалить продукт
	http.HandleFunc("/products/quantity/", updateProductQuantityHandler) // Обновить количество товара
	http.HandleFunc("/products/favorite/", toggleFavoriteHandler)        // Добавить/удалить из избранного
	http.HandleFunc("/products/cart/", toggleCartHandler)                // Добавить/удалить из корзины

	fmt.Println("Server is running on http://localhost:8080 !")
	http.ListenAndServe(":8080", nil)
}