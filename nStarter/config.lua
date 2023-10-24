Starter = {

  --- Argent, Mettre 0 si tu veux pas d'argent ---

  Moneycount = {
    BankCount = 5000, -- Argent en Banque
    BlackMoneyCount = 5000, -- Argent Sale
    CashCount = 5000 -- Argent Liquide
  },

  --- Item, tu peux mettre autant que tu veux en item ---

  Item = { --
    {count = 5, name = "sandwich"},
    {count = 5, name = "water"},
    {count = 1, name = "phone"}
  },

  --- Traduction, tu peux mettre ce que tu veux comme tu le veux ---

  Traduction = {
    MenuName = "~p~Menu Arrivée",
    SubMenuName = "~p~rDev",

    ButtonName = "Pack Démarrage",
    DescriptionName = "Contient: ~r~0 coin, 2500€, 5 Bouteilles d'eau et 5 Pains",

    NotificationName = "rDev",
    NotificationDescription = "Vous avez reçu : ~r~votre pack",
    NotificationLogo = "CHAR_MP_FM_CONTACT",

    HavePack = "→→ ~r~Vous avez déjà pris votre pack ~s~←←"
  },

  --- Voiture, si tu veux pas de voiture, tu mets "" ---
  
  Voiture = {
    VehiculeStarter = "sultan",
    Position = {
      x = -258.65,
      y = -995.58,
      z = 29.88,
      h = 252.68
    }
  },

  --- Crédit, Mettre 0 si tu veux pas de credit boutique ---

  Coin = {
    Count = "5000",
    NameCoin = "credit"
  },

  --- Position Menu, Si tu veux le déplacé ou changé le message ---

  Point = {
    Position = vector3(-264.074, -966.249, 31.224),
    Texte = "~r~ Appuyez sur [E] pour prendre votre pack",
    BlipsName = "Starter Pack",
    Blips = false
  },

  Weebhook = {
    Name = "StarterPack",
    Description = " à récupérer son pack de démarrage",
    Color = 2061822,
    weebhookLink = "https://discord.com/api/webhooks/1009272314345638082/"
  }
}