# 🎓 Projekt Studia – System ocen studentów

Aplikacja webowa w Ruby on Rails umożliwiająca zarządzanie studentami, semestrami i ocenami.
Projekt symuluje elektroniczny indeks studenta oraz panel dziekana.

---

## ✨ Funkcje

### Student
- lista studentów
- karta studenta
- średnia ocen
- podział na semestry
- dodawanie i usuwanie ocen (bez przeładowania strony – Turbo Frames)
- generowanie PDF indeksu

### Dziekan (dashboard)
- liczba studentów
- liczba grup
- najlepszy student
- średnia całej uczelni
- ranking studentów dla semestru

---

## 🧠 Technologie

- Ruby on Rails 8
- Hotwire (Turbo + Stimulus)
- SQLite
- Tailwind CSS
- WickedPDF (PDF)
- Hotwire Turbo Frames

---

## ⚙️ Instalacja

```bash
git clone https://github.com/TWOJ_LOGIN/projekt_studia.git
cd projekt_studia
bundle install
rails db:migrate
rails db:seed
rails server
```

Otwórz w przeglądarce:
```
http://localhost:3000
```

---

## 📄 PDF

Na stronie studenta kliknij:
> **PDF indeksu**

Plik generowany jest przez `wkhtmltopdf` i gem `wicked_pdf`.

---

## 🧪 Testowane funkcje

✔ przełączanie semestrów bez przeładowania  
✔ dodawanie ocen  
✔ usuwanie ocen  
✔ obliczanie średnich  
✔ ranking  
✔ PDF  

---

## 👨‍💻 Autor
Andrzej Antosz

Projekt wykonany jako zaliczenie przedmiotu *Programowanie Webowe / Ruby on Rails*
