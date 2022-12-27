class Film {
  final String id;
  final String baslik;
  final String resimAdresi;

  Film({required this.id, required this.baslik, required this.resimAdresi});

  static List<Film> filmleriGetir() {
    return [
      Film(id: "1", baslik: "Hulk", resimAdresi: "images/films/Hulk.jpg"),
      Film(
          id: "2",
          baslik: "The Batman",
          resimAdresi: "images/films/TheBatman.jpg"),
      Film(id: "3", baslik: "Split", resimAdresi: "images/films/Split.jpg"),
      Film(
          id: "4",
          baslik: "The Prestige",
          resimAdresi: "images/films/ThePrestige.jpg"),
      Film(
          id: "5",
          baslik: "Pulp Fiction",
          resimAdresi: "images/films/PulpFiction.jpg"),
      Film(
          id: "6",
          baslik: "A Quiet Place",
          resimAdresi: "images/films/AQuietPlace.jpg"),
      Film(
          id: "7",
          baslik: "Ex Machina",
          resimAdresi: "images/films/ExMachina.jpg"),
      Film(
          id: "8",
          baslik: "Snowpiercer",
          resimAdresi: "images/films/Snowpiercer.jpg"),
      Film(id: "9", baslik: "Memento", resimAdresi: "images/films/Memento.jpg"),
      Film(
          id: "10",
          baslik: "The Truman Show",
          resimAdresi: "images/films/TheTrumanShow.jpg"),
      Film(
          id: "11",
          baslik: "The Departed",
          resimAdresi: "images/films/TheDeparted.jpg"),
      Film(
          id: "12",
          baslik: "The Wolf of Wall Street",
          resimAdresi: "images/films/The WolfofWallStreet.jpg"),
      Film(
          id: "13",
          baslik: "Edge of Tomorrow",
          resimAdresi: "images/films/Edge of Tomorrow.jpg"),
      Film(
          id: "14", baslik: "Gravity", resimAdresi: "images/films/Gravity.jpg"),
      Film(
          id: "15",
          baslik: "The Invisible Guest",
          resimAdresi: "images/films/TheInvisibleGuest.jpg"),
      Film(
          id: "16",
          baslik: "V for Vendetta",
          resimAdresi: "images/films/VforVendetta.jpg"),
      Film(
          id: "17", baslik: "Upgrade", resimAdresi: "images/films/Upgrade.jpg"),
      Film(
          id: "18",
          baslik: "The Number 23",
          resimAdresi: "images/films/TheNumber23.jpg"),
      Film(
          id: "19",
          baslik: "Bird Box",
          resimAdresi: "images/films/BirdBox.jpg"),
      Film(
          id: "20",
          baslik: "Doctor Strange",
          resimAdresi: "images/films/DoctorStrange.jpg"),
      Film(id: "21", baslik: "Lucy", resimAdresi: "images/films/Lucy.jpg"),
      Film(
          id: "22",
          baslik: "John Wick",
          resimAdresi: "images/films/JohnWick.jpg"),
      Film(
          id: "23",
          baslik: "Predestination",
          resimAdresi: "images/films/Predestination.jpg"),
      Film(
          id: "24", baslik: "Arrival", resimAdresi: "images/films/Arrival.jpg"),
      Film(
          id: "25",
          baslik: "The Platform",
          resimAdresi: "images/films/ThePlatform.jpg"),
      Film(
          id: "26",
          baslik: "The Loft",
          resimAdresi: "images/films/TheLoft.jpg"),
      Film(
          id: "27",
          baslik: "Fight Club",
          resimAdresi: "images/films/FightClub.jpg"),
      Film(id: "28", baslik: "Tenet", resimAdresi: "images/films/Tenet.jpg"),
      Film(
          id: "29",
          baslik: "Harry Potter",
          resimAdresi: "images/films/HarryPotter.jpg"),
      Film(
          id: "30",
          baslik: "The Avengers",
          resimAdresi: "images/films/TheAvengers.jpg"),
      Film(id: "31", baslik: "Fury", resimAdresi: "images/films/Fury.jpg"),
    ];
  }
}
