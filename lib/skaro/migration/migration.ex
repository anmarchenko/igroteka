defmodule Skaro.Migration do
  @moduledoc """
  The big migration to IGDB
  """

  alias Skaro.Backlog.{AvailablePlatform, Entry}
  alias Skaro.Repo

  @mapping [
    {5,
     %{
       developers: [%{id: 13512, name: "Alike Studio"}],
       franchises: [],
       id: 68476,
       name: "Love You To Bits",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"}
       ],
       poster: %{
         id: "abuhidi5ifhtb1gr3c3u",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/abuhidi5ifhtb1gr3c3u.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/abuhidi5ifhtb1gr3c3u.jpg"
       },
       publishers: [],
       release_date: ~U[2016-02-25 00:00:00Z],
       short_description:
         "“Love You to Bits” is a crazy cute, purely visual, puzzle-filled, point-and-click, sci-fi adventure spanning all around the universe. \n \nYou will follow the journey of Kosmo, a clumsy, rookie space explorer in search of Nova, his robot girlfriend. After a fatal accident, all of Nova’s pieces get scattered in outer space! So now Kosmo wants to retrieve all Nova’s bits, rebuild her, and get back together. \n \nExplore the strangest worlds and planets, full of fantastic aliens, space-time puzzles, and hidden objects to collect. As you complete levels, you will discover Kosmo and Nova’s heartbreaking love story!"
     }, %{id: 39, name: "iOS"}},
    {473,
     %{
       developers: [%{id: 51, name: "Blizzard Entertainment"}],
       franchises: [],
       id: 120,
       name: "Diablo III",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1o6t",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1o6t.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1o6t.jpg"
       },
       publishers: [%{id: 51, name: "Blizzard Entertainment"}, %{id: 26, name: "Square Enix"}],
       release_date: ~U[2012-05-15 00:00:00Z],
       short_description:
         "The game takes place in Sanctuary, the dark fantasy world of the Diablo series, twenty years after the events of Diablo II. Deckard Cain and his niece Leah are in the Tristram Cathedral investigating ancient texts regarding an ominous prophecy. Suddenly, a mysterious star falling from the sky strikes the Cathedral, creating a deep crater into which Deckard Cain disappears."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {34,
     %{
       developers: [%{id: 2518, name: "The Astronauts"}],
       franchises: [],
       id: 2939,
       name: "The Vanishing of Ethan Carter",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "hhd9q2015jybxcaxgmhn",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/hhd9q2015jybxcaxgmhn.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/hhd9q2015jybxcaxgmhn.jpg"
       },
       publishers: [%{id: 2518, name: "The Astronauts"}],
       release_date: ~U[2014-09-25 00:00:00Z],
       short_description:
         "In The Vanishing of Ethan Carter, you play as Paul Prospero, an occult detective who receives a disturbing letter from Ethan Carter and realizes that the boy is in grave danger. When Paul arrives in Ethan’s home of Red Creek Valley, he realizes things are even worse than he imagined. Ethan has vanished in the wake of a brutal murder, which Paul comes to see might not be the only murder to investigate. Using both regular and supernatural detective skills, Paul must figure out what happened to the missing boy."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {39,
     %{
       developers: [%{id: 852, name: "Platinum Games"}],
       franchises: [%{id: 463, name: "Metal Gear"}],
       id: 378,
       name: "Metal Gear Rising: Revengeance",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "f7vy3oeezbgihn4f1k24",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/f7vy3oeezbgihn4f1k24.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/f7vy3oeezbgihn4f1k24.jpg"
       },
       publishers: [%{id: 129, name: "Konami"}],
       release_date: ~U[2013-02-19 00:00:00Z],
       short_description:
         "Developed by Kojima Productions and PlatinumGames, METAL GEAR RISING: REVENGEANCE takes the renowned METAL GEAR franchise into exciting new territory with an all-new action experience. The game seamlessly melds pure action and epic story-telling that surrounds Raiden – a child soldier transformed into a half-human, half-cyborg ninja who uses his High Frequency katana blade to cut through any thing that stands in his vengeful path! \n \nA huge success on both Xbox 360® and PlayStation®3, METAL GEAR RISING: REVENGEANCE comes to PC with all the famed moves and action running within a beautifully-realised HD environment. \n \nThis new PC version includes all three DLC missions: Blade Wolf, Jetstream, and VR Missions, in addition to all customized body upgrades for Raiden, including: White Armor, Inferno Armor, Commando Armor, Raiden’s MGS4 body, and the ever-popular Cyborg Ninja. \n \n\"CUTSCENES\" option added to the Main Menu. Play any and all cutscenes. \n \n\"CODECS\" option added to the Main Menu. Play all and any codec conversation scenes. \n \nMenu option added to the CHAPTER Menu enabling user to play only the Boss battles. \n \n\"GRAPHIC OPTIONS\" added to the OPTIONS Menu. Modify resolution, anti-aliasing, etc. \n There is an option reading \"ZANGEKI\" that will modify the amount of cuts you can make."
     }, %{id: 12, name: "Xbox 360"}},
    {581,
     %{
       developers: [%{id: 326, name: "Cyan Worlds"}],
       franchises: [],
       id: 8983,
       name: "Obduction",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"}
       ],
       poster: %{
         id: "co1k88",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1k88.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1k88.jpg"
       },
       publishers: [%{id: 326, name: "Cyan Worlds"}],
       release_date: ~U[2016-08-24 00:00:00Z],
       short_description:
         "Obduction is a first person puzzle game in the vein of Myst and Riven, set in a presumably new universe and marking a triumphant return to the genre by Cyan Worlds, pioneers of the genre in it's infancy. Obduction is being designed in Unreal Engine 4, and according to Cyan Worlds will be making a return to the full motion video acted sequences seen in the early Myst series games.\n\n\"From Cyan, the indie studio that brought you Myst and Riven comes a whole new adventure that will become your world. \n\nThe new worlds of Obduction reveal their secrets only as you explore, coax, and consider them. And as you bask in the otherworldly beauty and explore through the enigmatic landscapes, remember that the choices you make will have substantial consequences. This is your story now.\""
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {46,
     %{
       developers: [%{id: 2, name: "BioWare"}],
       franchises: [],
       id: 78,
       name: "Dragon Age II",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1pkw",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1pkw.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1pkw.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}, %{id: 1053, name: "Spike"}],
       release_date: ~U[2011-03-08 00:00:00Z],
       short_description:
         "Dragon Age: Origins is the award winning dark heroic fantasy roleplaying game developed by BioWare. Awakening is an expansion pack that features a new opportunity for players to continue the exploits of their Origins character or to start a new character facing an all new darkspawn threat. \nFor centuries, the Grey Wardens—the ancient order of guardians, sworn to unite and defend the lands—have been battling the darkspawn forces. Legend spoke that slaying the Archdemon would have put an end to the darkspawn threat for centuries to come, but somehow they remain. \nYou are the Grey Warden Commander and have been entrusted with the duty of rebuilding the order of Grey Wardens and uncovering the secrets of the darkspawn and how they managed to remain. \nHow you choose to rebuild your order, how you resolve the conflict with \"The Architect\", and how you determine the fate of the darkspawn will be but some of the many complex choices that await and shape your journey as you venture to the new land of Amaranthine."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {390,
     %{
       developers: [%{id: 15790, name: "Ubisoft Québec"}],
       franchises: [%{id: 571, name: "Assassin's Creed"}],
       id: 103_054,
       name: "Assassin's Creed: Odyssey",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 170, name: "Google Stadia"}
       ],
       poster: %{
         id: "co1pu6",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1pu6.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1pu6.jpg"
       },
       publishers: [%{id: 104, name: "Ubisoft Entertainment"}],
       release_date: ~U[2018-10-05 00:00:00Z],
       short_description:
         "Live the epic odyssey of a legendary Spartan hero, write your own epic odyssey and become a legendary Spartan hero in Assassin's Creed Odyssey, an inspiring adventure where you must forge your destiny and define your own path in a world on the brink of tearing itself apart. Influence how history unfolds as you experience a rich and ever-changing world shaped by your decisions."
     }, %{id: 48, name: "PlayStation 4"}},
    {8,
     %{
       developers: [
         %{id: 30, name: "Team Bondi"},
         %{id: 365, name: "Rockstar North"},
         %{id: 308, name: "Rockstar Leeds"}
       ],
       franchises: [],
       id: 109,
       name: "L.A. Noire",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "usohlmbhqiuzl5coafdu",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/usohlmbhqiuzl5coafdu.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/usohlmbhqiuzl5coafdu.jpg"
       },
       publishers: [%{id: 29, name: "Rockstar Games"}, %{id: 139, name: "Take-Two Interactive"}],
       release_date: ~U[2011-05-17 00:00:00Z],
       short_description:
         "L.A. Noire is a neo-noir detective action-adventure video game developed by Team Bondi and published by Rockstar Games. It was initially released for the PlayStation 3 and Xbox 360 platforms on 17 May 2011; a Microsoft Windows port was later released on 8 November 2011. \n \nL.A. Noire is set in Los Angeles in 1947 and challenges the player, controlling a Los Angeles Police Department (LAPD) officer, to solve a range of cases across five divisions. Players must investigate crime scenes for clues, follow up leads, and interrogate suspects, and the player's success at these activities will impact how much of each case's story is revealed. \n \nThe game draws heavily from both the plot and aesthetic elements of film noir—stylistic films made popular in the 1940s and 1950s that share similar visual styles and themes, including crime and moral ambiguity—along with drawing inspiration from real-life crimes for its in-game cases, based upon what was reported by the Los Angeles media in 1947. \n \nThe game uses a distinctive colour palette, but in homage to film noir it includes the option to play the game in black and white. Various plot elements reference the major themes of detective and mobster stories such as The Naked City, Chinatown, The Untouchables, The Black Dahlia, and L.A. Confidential."
     }, %{id: 12, name: "Xbox 360"}},
    {6,
     %{
       developers: [%{id: 7466, name: "Paradox Development Studio"}],
       franchises: [],
       id: 1904,
       name: "Europa Universalis IV",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "wq0tswx231bzvfdelxtx",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/wq0tswx231bzvfdelxtx.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/wq0tswx231bzvfdelxtx.jpg"
       },
       publishers: [%{id: 517, name: "Paradox Interactive"}],
       release_date: ~U[2013-08-13 00:00:00Z],
       short_description:
         "Paradox Development Studio is back with the fourth installment of the game that defined the Grand Strategy Genre. Europa Universalis IV gives you control of a nation to guide through the years in order to create a dominant global empire. Rule your nation through the centuries, with unparalleled freedom, depth and historical accuracy.\n\nTrue exploration, trade, warfare and diplomacy will be brought to life in this epic title rife with rich strategic and tactical depth."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {17,
     %{
       developers: [%{id: 170, name: "Kojima Productions"}],
       franchises: [%{id: 463, name: "Metal Gear"}],
       id: 1985,
       name: "Metal Gear Solid V: The Phantom Pain",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1pjc",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1pjc.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1pjc.jpg"
       },
       publishers: [%{id: 129, name: "Konami"}],
       release_date: ~U[2015-09-01 00:00:00Z],
       short_description:
         "The 5th installment of the Metal Gear Solid saga, Metal Gear Solid V: The Phantom Pain continues the story of Big Boss (aka Naked Snake, aka David), connecting the story lines from Metal Gear Solid: Peace Walker, Metal Gear Solid: Ground Zeroes, and the rest of the Metal Gear Universe."
     }, %{id: 48, name: "PlayStation 4"}},
    {45,
     %{
       developers: [%{id: 7, name: "Visceral Games"}],
       franchises: [],
       id: 38,
       name: "Dead Space 2",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "co1n0j",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1n0j.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1n0j.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2011-01-25 00:00:00Z],
       short_description: "The Nightmare returns..."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {18,
     %{
       developers: [%{id: 222, name: "BioWare Edmonton"}, %{id: 2, name: "BioWare"}],
       franchises: [],
       id: 75,
       name: "Mass Effect 3",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 41, name: "Wii U"}
       ],
       poster: %{
         id: "uhfdlwlxixe3out9bmzx",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/uhfdlwlxixe3out9bmzx.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/uhfdlwlxixe3out9bmzx.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2012-03-06 00:00:00Z],
       short_description:
         "Earth is burning. The Reapers have taken over and other civilizations are falling like dominoes. Lead the final fight to save humanity and take back Earth from these terrifying machines, Commander Shepard. You'll need backup for these battles. Fortunately, the galaxy has a habit of sending unexpected species your way. Recruit team members and forge new alliances, but be prepared to say goodbye at any time as partners make the ultimate sacrifice. It's time for Commander Shepard to fight for the fate of the human race and save the galaxy. No pressure, Commander. \n \nFight smarter. Take advantage of new powers and combat moves. Shepard can now blind fire at enemies and build tougher melee attacks. Plus, when you fight as a team you can combine new biotic and tech powers to unleash devastating Power Combos. \n \nBuild the final force. Build a team from a variety of races and classes and combine their skills to overcome impossible odds. You'll be joined by newcomers like James Vega, a tough-as-nails soldier, as well as EDI, a trusted AI in a newly acquired physical form. Keep an eye out for beloved characters from your past, but beware. Some may not survive the final battle... \n \nFace off against friends. Enjoy an integrated co-op multiplayer mode and team up with friends online to liberate key conflict zones from increasingly tough opponents. Customize your warrior and earn new weapons, armor, and abilities to build war preparedness stats in your single player campaign."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {13,
     %{
       developers: [%{id: 184, name: "id Software"}],
       franchises: [%{id: 798, name: "Doom"}],
       id: 7351,
       name: "DOOM",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1nc7",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nc7.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nc7.jpg"
       },
       publishers: [%{id: 28, name: "Bethesda Softworks LLC"}],
       release_date: ~U[2016-05-13 00:00:00Z],
       short_description:
         "Developed by id software, the studio that pioneered the first-person shooter genre and created multiplayer Deathmatch, DOOM returns as a brutally fun and challenging modern-day shooter experience. Relentless demons, impossibly destructive guns, and fast, fluid movement provide the foundation for intense, first-person combat – whether you’re obliterating demon hordes through the depths of Hell in the single-player campaign, or competing against your friends in numerous multiplayer modes. Expand your gameplay experience using DOOM SnapMap game editor to easily create, play, and share your content with the world."
     }, %{id: 48, name: "PlayStation 4"}},
    {596,
     %{
       developers: [%{id: 331, name: "Triumph Studios"}],
       franchises: [],
       id: 102_057,
       name: "Age of Wonders: Planetfall",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "co1lmf",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1lmf.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1lmf.jpg"
       },
       publishers: [%{id: 517, name: "Paradox Interactive"}],
       release_date: ~U[2019-08-06 00:00:00Z],
       short_description:
         "\"Age of Wonders: Planetfall is the new strategy game from Triumph Studios, creators of the critically acclaimed Age of Wonders and Overlord series, bringing all the exciting tactical-turn based combat and in-depth 4X empire building of its predecessors to space in an all-new sci-fi setting. \n \nEmerge from the cosmic dark age of a fallen galactic empire to craft a new future for your people. Explore the planetary ruins and encounter other surviving factions that have each evolved in their own way, as you unravel the history of a shattered civilization. Fight, build, negotiate and technologically advance your way to utopia, in a deep single player campaign, on random maps and against friends in multiplayer.\""
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {413,
     %{
       developers: [%{id: 852, name: "Platinum Games"}],
       franchises: [],
       id: 2135,
       name: "Bayonetta 2",
       platforms: [%{id: 41, name: "Wii U"}, %{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "qocwccspgmgamvhaplgp",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/qocwccspgmgamvhaplgp.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/qocwccspgmgamvhaplgp.jpg"
       },
       publishers: [%{id: 70, name: "Nintendo"}],
       release_date: ~U[2014-09-20 00:00:00Z],
       short_description:
         "The witching hour strikes again. Brimming with intricate battles that take place in, on and all over epic set pieces, Bayonetta 2 finds our sassy heroine battling angels and demons in unearthly beautiful HD. You’re bound to love how it feels to string together combos with unimaginable weapons and to summon demons using Bayonetta’s Umbran Weave in this frantic stylized action game."
     }, %{id: 130, name: "Nintendo Switch"}},
    {19,
     %{
       developers: [%{id: 280, name: "Starbreeze Studios"}],
       franchises: [],
       id: 1334,
       name: "Brothers: A Tale of Two Sons",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 34, name: "Android"},
         %{id: 36, name: "Xbox Live Arcade"},
         %{id: 39, name: "iOS"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 74, name: "Windows Phone"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "ecstnq8wxbz93mkjndrq",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/ecstnq8wxbz93mkjndrq.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/ecstnq8wxbz93mkjndrq.jpg"
       },
       publishers: [%{id: 1217, name: "Spike ChunSoft"}, %{id: 445, name: "505 Games"}],
       release_date: ~U[2013-08-07 00:00:00Z],
       short_description:
         "Brothers is presented from a third-person view overlooking the two brothers. The brothers are moved individually by two thumbsticks on the controller. The controller triggers also cause the respective brother to interact with the game world, such as talking to a non-player character or grabbing onto a ledge or object. \n \nThe older brother is the stronger of the two and can pull levers or boost his younger brother to higher spaces, while the younger one can pass between narrow bars. The player progresses by manipulating the two brothers at the same time to complete various puzzles, often requiring the player to manipulate both brothers to perform differing functions (such as one distracting a hostile non-player character while the other makes their way around). \n \nShould either brother fall from a great height or get injured, the game restarts at a recent checkpoint. All of the in-game dialogue is spoken in a fictional language, thus the story is conveyed through actions, gestures and expressions."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {29,
     %{
       developers: [%{id: 1424, name: "Galactic Cafe"}],
       franchises: [],
       id: 3035,
       name: "The Stanley Parable",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1qsf",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qsf.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qsf.jpg"
       },
       publishers: [%{id: 1424, name: "Galactic Cafe"}],
       release_date: ~U[2013-10-17 00:00:00Z],
       short_description:
         "The Stanley Parable is a first-person exploration game which ponders questions related to player agency, narrative pacing, escapism through gaming, objective-driven game design, authorial intent, and the conflict of interest between players and game creators."
     }, %{id: 6, name: "PC (Microsoft Windows)"}}
  ]

  def run do
    Repo.delete_all(AvailablePlatform)

    Enum.each(@mapping, fn {entry_id, game, platform} ->
      Entry
      |> Repo.get!(entry_id)
      |> Repo.preload([:available_platforms])
      |> Entry.migrate(%{
        "game_id" => game.id,
        "game_name" => game.name,
        "poster_thumb_url" => game.poster.thumb_url,
        "game_release_date" => game.release_date,
        "available_platforms" =>
          Enum.map(game.platforms, fn p -> %{platform_name: p.name, platform_id: p.id} end),
        "owned_platform_id" => platform.id,
        "owned_platform_name" => platform.name
      })
      |> Repo.update()
    end)
  end
end
