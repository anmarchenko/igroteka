defmodule Skaro.Migration do
  @moduledoc """
  The big migration to IGDB
  """

  alias Skaro.Backlog.{AvailablePlatform, Entry}
  alias Skaro.Repo

  @mapping [
    {432,
     %{
       developers: [%{id: 2542, name: "Image & Form"}],
       franchises: [],
       id: 77648,
       name: "SteamWorld Heist: Ultimate Edition",
       platforms: [%{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "m2zmdbxk7qfvnh7nfztj",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/m2zmdbxk7qfvnh7nfztj.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/m2zmdbxk7qfvnh7nfztj.jpg"
       },
       publishers: [%{id: 2542, name: "Image & Form"}],
       release_date: ~U[2017-12-28 00:00:00Z],
       short_description:
         "\"SteamWorld Heist: Ultimate Edition is fully optimized for Nintendo Switch™ and comes with extra content previously only available as DLC. Including a mysterious ally and a shipload of weapons, upgrades, hats, and missions. Accompanied by a catchy soundtrack by Steam Powered Giraffe, you’re in for an out-of-this-world adventure. \n \nWhat are you waiting for? Prepare for boarding!\""
     }, %{id: 130, name: "Nintendo Switch"}},
    {574,
     %{
       developers: [%{id: 442, name: "Asobo Studio"}],
       franchises: [],
       id: 27316,
       name: "A Plague Tale: Innocence",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1lat",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1lat.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1lat.jpg"
       },
       publishers: [%{id: 110, name: "Focus Home Interactive"}],
       release_date: ~U[2019-05-14 00:00:00Z],
       short_description:
         "A Plague Tale: Innocence, on PlayStation 4, Xbox One and PC, tells the grim story of two siblings fighting together for survival in the darkest hours of History. This new video game from Asobo Studio sends you on an emotional journey through the 14th century France, with gameplay combining adventure, action and stealth, supported by a compelling story. Follow the young Amicia and her little brother Hugo, who face the brutality of a ravaged world as they discover their purpose to expose a dark secret. On the run from the Inquisition's soldiers, surrounded by unstoppable swarms of rats incarnating the Black Death, Amicia and Hugo will learn to know and trust each other as they struggle for their lives against all odds."
     }, %{id: 48, name: "PlayStation 4"}},
    {546,
     %{
       developers: [%{id: 14, name: "Bullfrog Productions"}],
       franchises: [],
       id: 51,
       name: "Syndicate Wars",
       platforms: [%{id: 7, name: "PlayStation"}, %{id: 13, name: "PC DOS"}],
       poster: %{
         id: "jik18ilxkogyurxyfave",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/jik18ilxkogyurxyfave.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/jik18ilxkogyurxyfave.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[1996-10-31 00:00:00Z],
       short_description:
         "Welcome to an urban hell of ultra-violent mayhem. Welcome to Syndicate Wars where you’ll take control of a squad of cybernetically enhanced Agents and wreak havoc on the enemy. Funnel money towards research that will allow you to upgrade your team and make them into more efficient killing machines. Use the environment to assassinate, destroy, and eliminate your targets all from a classic isometric perspective. If you need cannon fodder, why not set your Agents loose armed with Persuadertrons to control huge crowds, or even enemy agents, and get them to do the dirty work for you? So whether you’re keeping EuroCorp in the black or burning infidels for the New Epoch, Syndicate Wars will have you giddily carving a path to victory. Welcome to the merciless future of violent squad-based real-time tactics!"
     }, %{id: 13, name: "PC DOS"}},
    {519,
     %{
       developers: [%{id: 804, name: "Beam Software"}],
       franchises: [],
       id: 24701,
       name: "KKnD",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "paisxg69rdqakt7tv6fa",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/paisxg69rdqakt7tv6fa.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/paisxg69rdqakt7tv6fa.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[1997-03-25 00:00:00Z],
       short_description:
         "KKnD, or Krush, Kill 'n' Destroy is a real-time strategy games in the KKnD series. The game takes place in a post-apocalyptic setting, where two factions are fighting for control over the few natural resources left. Each faction has its own campaign consisting of 15 missions each, and there is also a multiplayer mode which allows up to 6 people to play."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {538,
     %{
       developers: [%{id: 152, name: "MicroProse"}, %{id: 180, name: "Mythos Games"}],
       franchises: [],
       id: 24,
       name: "UFO: Enemy Unknown",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 13, name: "PC DOS"},
         %{id: 16, name: "Amiga"}
       ],
       poster: %{
         id: "ktncvwaufyr5m92pwuap",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/ktncvwaufyr5m92pwuap.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/ktncvwaufyr5m92pwuap.jpg"
       },
       publishers: [%{id: 152, name: "MicroProse"}, %{id: 1044, name: "Spectrum HoloByte, Inc."}],
       release_date: ~U[1994-06-30 00:00:00Z],
       short_description:
         "You are in control of X-COM: an organization formed by the world's governments to fight the ever-increasing alien menace.\n\nShooting down UFOs is just the beginning: you must then lead a squad of heavily-armed soldiers across different terrains as they investigate the UFO crash site. Tackle the aliens with automatic rifles, rocket launchers, and even tanks in the struggle to retrieve useful technology, weapons or life forms.\n\nSuccessful ground assault missions will allow X-COM scientists to analyze alien items. Each new breakthrough brings you a little closer to understanding the technology and culture of the alien races. Once you have sufficient research data on the UFO's superior weapons and crafts, you'll be able to manufacture weapons of equal capability.\n\nYou must make every crucial decision as you combat the powerful alien forces. But you'll also need to watch the world political situation: governments may be forced into secret pacts with the aliens and then begin to reduce X-COM funding."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {560,
     %{
       developers: [%{id: 37, name: "Capcom"}],
       franchises: [%{id: 29, name: "Resident Evil"}],
       id: 19686,
       name: "Resident Evil 2",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1ir3",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ir3.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ir3.jpg"
       },
       publishers: [%{id: 37, name: "Capcom"}],
       release_date: ~U[2019-01-25 00:00:00Z],
       short_description:
         "The genre-defining masterpiece Resident Evil 2 returns, completely rebuilt from the ground up for a deeper narrative experience. Using Capcom’s proprietary RE Engine, Resident Evil 2 offers a fresh take on the classic survival horror saga with breathtakingly realistic visuals, heart-poundingly immersive audio, a new over-the-shoulder camera, and modernized controls on top of gameplay modes from the original game. The nightmares return reimagined for the PlayStation®4, Xbox One and Windows PC on January 25, 2019. \n \nIn Resident Evil 2, the classic action, tense exploration, and puzzle solving gameplay that defined the Resident Evil series returns. Players join rookie police officer Leon Kennedy and college student Claire Redfield, who are thrust together by a disastrous outbreak in Raccoon City that transformed its population into deadly zombies. Both Leon and Claire have their own separate playable campaigns, allowing players to see the story from both characters’ perspectives. The fate of these two fan favorite characters is in players hands as they work together to survive and get to the bottom of what is behind the terrifying attack on the city. Will they make it out alive?"
     }, %{id: 48, name: "PlayStation 4"}},
    {531,
     %{
       developers: [%{id: 284, name: "Maxis"}],
       franchises: [%{id: 1017, name: "Sim"}],
       id: 330,
       name: "SimCity 2000",
       platforms: [
         %{id: 4, name: "Nintendo 64"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"},
         %{id: 16, name: "Amiga"},
         %{id: 19, name: "Super Nintendo Entertainment System (SNES)"},
         %{id: 32, name: "Sega Saturn"}
       ],
       poster: %{
         id: "co1o4d",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1o4d.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1o4d.jpg"
       },
       publishers: [
         %{id: 1, name: "Electronic Arts"},
         %{id: 354, name: "DSI Games"},
         %{id: 355, name: "Zoo Digital"},
         %{id: 284, name: "Maxis"}
       ],
       release_date: ~U[1994-01-01 00:00:00Z],
       short_description:
         "It has all the features, flexibility, art, animation, and power you need to create an environment of your dreams. Choose from a selection of bonus cities and scenarios to rule or ruin as you please. Build schools, libraries, hospitals, zoos, prisons, power plants, and much more... Lay down roads, railways, and highways. Explore the underground layer and build subways and utilities without compromising your aesthetics. Customize different buildings or design your own graphics sets from scratch. \n \nThis is the ultimate classic Maxis city-building and management simulation. If this game were any more realistic, it'd be illegal to turn it off!"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {563,
     %{
       developers: [%{id: 11259, name: "Warm Lamp Games"}],
       franchises: [],
       id: 82372,
       name: "Beholder: Complete Edition",
       platforms: [
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1mdf",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mdf.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mdf.jpg"
       },
       publishers: [%{id: 8628, name: "Alawar Entertainment"}, %{id: 5048, name: "Curve Digital"}],
       release_date: ~U[2018-01-16 00:00:00Z],
       short_description:
         "A totalitarian State controls every aspect of private and social life. Laws are oppressive. Surveillance is total. Privacy is dead. You are a State-installed manager of an apartment house. The State requires you to spy on your tenants, and report any illegal or subversive activity. However, you can also choose to keep the information to yourself, or use it to blackmail the residents, resulting in a multitude of choices and endings. \n \nAlso includes: Blissful Sleep DLC"
     }, %{id: 130, name: "Nintendo Switch"}},
    {495,
     %{
       developers: [
         %{id: 263, name: "Namco"},
         %{id: 2066, name: "Nova Games"},
         %{id: 2067, name: "Dempa Shimbunsha"}
       ],
       franchises: [],
       id: 4596,
       name: "Battle City",
       platforms: [
         %{id: 33, name: "Game Boy"},
         %{id: 47, name: "Virtual Console (Nintendo)"},
         %{id: 51, name: "Family Computer Disk System"}
       ],
       poster: %{
         id: "j9t3npwfeitbcwyqwvgq",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/j9t3npwfeitbcwyqwvgq.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/j9t3npwfeitbcwyqwvgq.jpg"
       },
       publishers: [%{id: 263, name: "Namco"}],
       release_date: ~U[1985-09-09 00:00:00Z],
       short_description:
         "Battle City (バトルシティー Batoru Shitī), also known as Tank 1990 or Tank in some pirate multicarts releases is a multi-directional shooter video game for the Family Computer produced and published in 1985 by Namco. The game was later released for the Game Boy and was included in the Japanese version of Star Fox: Assault. It is a port of the arcade game Tank Battalion with additional features (including two player simultaneous play, and an edit feature, both explained later). There was also a rendition for Nintendo's Vs. System arcade cabinets.\n\nThe player, controlling a tank, must destroy enemy tanks in each level, which enter the playfield from the top of the screen. The enemy tanks attempt to destroy the player's base (represented on the map as a bird, eagle or Phoenix), as well as the human tank itself. A level is completed when the player destroys all 20 enemy Tanks, but the game ends if the player's base is destroyed or the player loses all available lives."
     }, %{id: 51, name: "Family Computer Disk System"}},
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
         id: "co1r7q",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r7q.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r7q.jpg"
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
         id: "co1r85",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r85.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r85.jpg"
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
         id: "co1r6n",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r6n.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r6n.jpg"
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
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {474,
     %{
       developers: [%{id: 613, name: "2D Boy"}],
       franchises: [],
       id: 942,
       name: "World of Goo",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 5, name: "Wii"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"},
         %{id: 56, name: "WiiWare"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1nca",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nca.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nca.jpg"
       },
       publishers: [
         %{id: 612, name: "Brighter Minds"},
         %{id: 613, name: "2D Boy"},
         %{id: 1010, name: "Microsoft Studios"}
       ],
       release_date: ~U[2008-10-13 00:00:00Z],
       short_description:
         "World of Goo is a multiple award winning physics based puzzle / construction game made entirely by two guys. Drag and drop living, squirming, talking, globs of goo to build structures, bridges, cannonballs, zeppelins, and giant tongues. The millions of Goo Balls that live in the beautiful World of Goo are curious to explore - but they don't know that they are in a game, or that they are extremely delicious. Congratulations, and good luck!"
     }, %{id: 34, name: "Android"}},
    {44,
     %{
       developers: [%{id: 11, name: "EA Redwood Shores"}],
       franchises: [],
       id: 37,
       name: "Dead Space",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "exlxirelwzpoqftj8phf",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/exlxirelwzpoqftj8phf.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/exlxirelwzpoqftj8phf.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2008-10-14 00:00:00Z],
       short_description:
         "Dead Space is a 2008 science fiction survival horror video game developed by EA Redwood Shores (now Visceral Games) for Microsoft Windows, PlayStation 3 and Xbox 360. The game was released on all platforms through October 2008. The game puts the player in control of an engineer named Isaac Clarke, who battles the Necromorphs, reanimated human corpses, aboard an interstellar mining ship, the USG Ishimura."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {408,
     %{
       developers: [%{id: 8452, name: "ConcernedApe"}],
       franchises: [],
       id: 17000,
       name: "Stardew Valley",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 46, name: "PlayStation Vita"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "xrpmydnu9rpxvxfjkiu7",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/xrpmydnu9rpxvxfjkiu7.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/xrpmydnu9rpxvxfjkiu7.jpg"
       },
       publishers: [%{id: 1418, name: "Chucklefish Games"}],
       release_date: ~U[2016-02-26 00:00:00Z],
       short_description:
         "Stardew Valley is an open-ended country-life RPG! You’ve inherited your grandfather’s old farm plot in Stardew Valley. Armed with hand-me-down tools and a few coins, you set out to begin your new life. Can you learn to live off the land and turn these overgrown fields into a thriving home? It won’t be easy. Ever since Joja Corporation came to town, the old ways of life have all but disappeared. The community center, once the town’s most vibrant hub of activity, now lies in shambles. But the valley seems full of opportunity. With a little dedication, you might just be the one to restore Stardew Valley to greatness!"
     }, %{id: 130, name: "Nintendo Switch"}},
    {479,
     %{
       developers: [%{id: 1701, name: "Ice-Pick Lodge"}],
       franchises: [],
       id: 8074,
       name: "Pathologic",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "u6asiqwedhuyxpbtnegk",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/u6asiqwedhuyxpbtnegk.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/u6asiqwedhuyxpbtnegk.jpg"
       },
       publishers: [%{id: 2992, name: "Buka Entertainment"}, %{id: 468, name: "Meridian4"}],
       release_date: ~U[2005-06-09 00:00:00Z],
       short_description:
         "Pathologic (known in Russian as Мор. Утопия) is an award winning 2005 psychological horror video game developed by the Russian studio Ice-Pick Lodge. It was published in Russia and other CIS-countries by Buka Entertainment. The game was published in the UK on 18 August 2006 by G2 Games. The game is going to be remade for Xbox One, PlayStation 4, Microsoft Windows, Mac OS X and Linux by Ice-Pick Lodge and self-published in 2015."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {462,
     %{
       developers: [%{id: 761, name: "Nintendo Research & Development 1"}],
       franchises: [],
       id: 2741,
       name: "Duck Hunt",
       platforms: [
         %{id: 18, name: "Nintendo Entertainment System (NES)"},
         %{id: 41, name: "Wii U"},
         %{id: 47, name: "Virtual Console (Nintendo)"},
         %{id: 52, name: "Arcade"}
       ],
       poster: %{
         id: "co1hp1",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1hp1.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1hp1.jpg"
       },
       publishers: [%{id: 70, name: "Nintendo"}],
       release_date: ~U[1984-04-21 00:00:00Z],
       short_description:
         "It’s duck season, and your trusty hunting dog is ready to scour the open fields. Test your sharpshooting skills as your targets take flight. Be quick to knock them out of the skies, or your canine companion won’t hesitate to make you the laughingstock of hunters! Need a change in scenery? Best your score against clay-pigeon targets instead! \n \nWith three fun modes to choose from, get your trigger finger ready for some fast-paced action! You only have three shots to hit your target before it zooms offscreen. Things might get a bit hairy when you advance to the next round, because those ducks and clay pigeons are going to fly faster and faster! Play solo, or challenge a friend as you test your dogged determination and feathered speed in this NES classic!"
     }, %{id: 18, name: "Nintendo Entertainment System (NES)"}},
    {477,
     %{
       developers: [%{id: 305, name: "Remedy Entertainment"}],
       franchises: [],
       id: 18,
       name: "Max Payne",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 8, name: "PlayStation 2"},
         %{id: 11, name: "Xbox"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"},
         %{id: 24, name: "Game Boy Advance"},
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"}
       ],
       poster: %{
         id: "co1ocs",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ocs.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ocs.jpg"
       },
       publishers: [
         %{id: 204, name: "Gathering of Developers"},
         %{id: 130, name: "MacSoft Games"},
         %{id: 29, name: "Rockstar Games"},
         %{id: 224, name: "3D Realms"},
         %{id: 139, name: "Take-Two Interactive"},
         %{id: 157, name: "1C Company"},
         %{id: 23, name: "Feral Interactive"}
       ],
       release_date: ~U[2001-07-23 00:00:00Z],
       short_description:
         "Max Payne, gritty ex-cop and titular hero of this third-person shooter, sets out on his own to take revenge on those who murdered his wife and child, only for the plot he's involved in to get deeper and deeper. As his guilt and trauma build, Payne finds himself in more and more impossibly unfavourable and astounding situations, which challenge his methods, his worldview, and even his existence."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {502,
     %{
       developers: [%{id: 142, name: "Westwood Pacific"}],
       franchises: [%{id: 12, name: "Command & Conquer"}],
       id: 245,
       name: "Command & Conquer: Red Alert 2",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "jryjuanclzzncnlzek08",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/jryjuanclzzncnlzek08.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/jryjuanclzzncnlzek08.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2000-10-23 00:00:00Z],
       short_description:
         "The Soviets are back and this time they’re on American soil. Fight for the red, white, and blue – or just the red. But be careful – the mystical madman Yuri, with his mysterious mind-control technology, is readying his army for a shot at world domination.Fight on the side of freedom or battle behind the Iron Curtain. Prism tanks, Tesla Troopers, Terror Drones, Desolators, Psychic Mind Control Giant Squid, and Sonic Dolphins are just a small part of your arsenal. Play either side in the full solo-play campaign or as one of the nine nations in eight modes of multiplayer."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {455,
     %{
       developers: [%{id: 1447, name: "Subset Games"}],
       franchises: [],
       id: 3075,
       name: "FTL: Faster Than Light",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 39, name: "iOS"}
       ],
       poster: %{
         id: "hu3vbtczuus3yfetdnqs",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/hu3vbtczuus3yfetdnqs.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/hu3vbtczuus3yfetdnqs.jpg"
       },
       publishers: [%{id: 1447, name: "Subset Games"}],
       release_date: ~U[2012-09-14 00:00:00Z],
       short_description:
         "In FTL you experience the atmosphere of running a spaceship trying to save the galaxy. It's a dangerous mission, with every encounter presenting a unique challenge with multiple solutions. What will you do if a heavy missile barrage shuts down your shields?"
     }, %{id: 14, name: "Mac"}},
    {465,
     %{
       developers: [%{id: 421, name: "Nintendo EAD"}],
       franchises: [%{id: 24, name: "Mario Bros."}],
       id: 358,
       name: "Super Mario Bros.",
       platforms: [
         %{id: 5, name: "Wii"},
         %{id: 18, name: "Nintendo Entertainment System (NES)"},
         %{id: 19, name: "Super Nintendo Entertainment System (SNES)"},
         %{id: 22, name: "Game Boy Color"},
         %{id: 24, name: "Game Boy Advance"},
         %{id: 37, name: "Nintendo 3DS"},
         %{id: 41, name: "Wii U"},
         %{id: 51, name: "Family Computer Disk System"}
       ],
       poster: %{
         id: "mrrnryomkk2hhmrwzk78",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/mrrnryomkk2hhmrwzk78.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/mrrnryomkk2hhmrwzk78.jpg"
       },
       publishers: [%{id: 70, name: "Nintendo"}],
       release_date: ~U[1985-09-13 00:00:00Z],
       short_description:
         "Do you have what it takes to save the Mushroom Princess? You’ll have to think fast and move even faster to complete this quest! The Mushroom Princess is being held captive by the evil Koopa tribe of turtles. It’s up to you to rescue her from the clutches of the Koopa King before time runs out. But it won’t be easy. To get to the Princess, you’ll have to climb mountains, cross seas, avoid bottomless pits, fight off turtle soldiers and a host of black magic traps that only a Koopa King can devise. It’s another non-stop adventure from the Super Mario Bros.!"
     }, %{id: 18, name: "Nintendo Entertainment System (NES)"}},
    {483,
     %{
       developers: [%{id: 6, name: "Lionhead Studios"}, %{id: 410, name: "Big Blue Box"}],
       franchises: [],
       id: 694,
       name: "Fable: The Lost Chapters",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 11, name: "Xbox"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1mh5",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mh5.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mh5.jpg"
       },
       publishers: [
         %{id: 53, name: "Microsoft Game Studios"},
         %{id: 23, name: "Feral Interactive"},
         %{id: 157, name: "1C Company"}
       ],
       release_date: ~U[2005-09-20 00:00:00Z],
       short_description:
         "Fable was expanded and rereleased as Fable: The Lost Chapters for Xbox and Windows PC platforms in September 2005. The game was later ported to Mac OS X by Robosoft Technologies and published by Feral Interactive on 31 March 2008. \nThe Lost Chapters features all the content found in the original Fable, as well as additional new content such as new monsters, weapons, alignment based spells, items, armour, towns, buildings, and expressions, as well as the ability to give children objects. The story receives further augmentation in the form of nine new areas and sixteen additional quests. Characters such as Briar Rose and Scythe, who played only minor roles in the original game, are now given more importance and are included in certain main and side quests. Other character-based augmentations include the voice of the antagonist, Jack of Blades, sounding deeper, harsher and more demonic, and the ability to uncover (and resolve) the murder mystery of Lady Grey's sister. The updated edition of the game also applied fixes for certain glitches, such as the \"dig glitch,\" in which the protagonist would move backward each time he used the shovel, pushing him through solid objects and sometimes trapping him."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {500,
     %{
       developers: [%{id: 106, name: "Loki Software"}, %{id: 97, name: "New World Computing"}],
       franchises: [%{id: 458, name: "Might and Magic"}],
       id: 364,
       name: "Heroes of Might and Magic III: The Restoration of Erathia",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "i0fg9iojshbjnrtpa2ar",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/i0fg9iojshbjnrtpa2ar.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/i0fg9iojshbjnrtpa2ar.jpg"
       },
       publishers: [%{id: 106, name: "Loki Software"}, %{id: 99, name: "The 3DO Company"}],
       release_date: ~U[1999-02-28 00:00:00Z],
       short_description:
         "Heroes of Might and Magic III: The Restoration of Erathia is a turn-based strategy game developed by Jon Van Caneghem through New World Computing originally released for Microsoft Windows by the 3DO Company in 1999. Its ports to several computer and console systems followed in 1999-2000. It is the third installment of the Heroes of Might and Magic series. The player can choose to play through seven different campaigns telling the story, or play in a scenario against computer or human opponents.\nThe gameplay is very similar to its predecessors in that the player controls a number of heroes that command an army of creatures inspired by myth and legend. The gameplay is divided into two parts, tactical overland exploration and a turn based combat system. The player creates an army by spending resources at one of the eight town types in the game. The hero will progress in experience by engaging in combat with enemy heroes and monsters. The conditions for victory vary depending on the map, including conquest of all enemies and towns, collection of a certain amount of a resource, or finding the grail artifact."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {496,
     %{
       developers: [%{id: 97, name: "New World Computing"}],
       franchises: [%{id: 458, name: "Might and Magic"}],
       id: 363,
       name: "Heroes of Might and Magic II: The Succession Wars",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "o1fbz1seqjaprynaw8bx",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/o1fbz1seqjaprynaw8bx.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/o1fbz1seqjaprynaw8bx.jpg"
       },
       publishers: [%{id: 99, name: "The 3DO Company"}],
       release_date: ~U[1996-10-01 00:00:00Z],
       short_description:
         "Heroes of Might and Magic II: The Succession Wars is a turn-based strategy video game developed by Jon Van Caneghem through New World Computing and published in 1996 by the 3DO Company. The game is the second installment of the Heroes of Might and Magic series and is typically credited as the breakout game for the series. Heroes II was voted the sixth-best PC game of all time by PC Gamer in May 1997."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {70,
     %{
       developers: [
         %{id: 324, name: "Square Soft"},
         %{id: 321, name: "Tose"},
         %{id: 26, name: "Square Enix"}
       ],
       franchises: [%{id: 4, name: "Final Fantasy"}],
       id: 426,
       name: "Final Fantasy VI",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 19, name: "Super Nintendo Entertainment System (SNES)"},
         %{id: 24, name: "Game Boy Advance"},
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 47, name: "Virtual Console (Nintendo)"},
         %{id: 58, name: "Super Famicom"}
       ],
       poster: %{
         id: "co1l92",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1l92.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1l92.jpg"
       },
       publishers: [
         %{id: 324, name: "Square Soft"},
         %{id: 70, name: "Nintendo"},
         %{id: 26, name: "Square Enix"},
         %{id: 440, name: "SCEE - duplicate"},
         %{id: 4107, name: "SCE Australia"},
         %{id: 324, name: "Square Soft"},
         %{id: 26, name: "Square Enix"}
       ],
       release_date: ~U[1994-04-02 00:00:00Z],
       short_description:
         "Part of the Final Fantasy turn-based Japanese RPG franchise, Final Fantasy VI follows an ensemble cast of characters as they attempt to save the their steampunk/fantasy land from the repercussions of the otherworldly campaigns of Emperor Gestahl and his court jester/general Kefka, while trying to resolve their personal issues together and find meaning in their own existence through their tumultuous journey."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {59,
     %{
       developers: [%{id: 126, name: "Bethesda Game Studios"}],
       franchises: [],
       id: 472,
       name: "The Elder Scrolls V: Skyrim",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "yakiwtuy29tu0atooopm",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/yakiwtuy29tu0atooopm.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/yakiwtuy29tu0atooopm.jpg"
       },
       publishers: [%{id: 28, name: "Bethesda Softworks LLC"}],
       release_date: ~U[2011-11-11 00:00:00Z],
       short_description:
         "The next chapter in the highly anticipated Elder Scrolls saga arrives from the makers of the 2006 and 2008 Games of the Year, Bethesda Game Studios. Skyrim reimagines and revolutionizes the open-world fantasy epic, bringing to life a complete virtual world open for you to explore any way you choose.  \n \nPlay any type of character you can imagine, and do whatever you want; the legendary freedom of choice, storytelling, and adventure of The Elder Scrolls is realized like never before.  \n \nSkyrim’s new game engine brings to life a complete virtual world with rolling clouds, rugged mountains, bustling cities, lush fields, and ancient dungeons.  \n \nChoose from hundreds of weapons, spells, and abilities. The new character system allows you to play any way you want and define yourself through your actions.  \n \nBattle ancient dragons like you’ve never seen. As Dragonborn, learn their secrets and harness their power for yourself."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {63,
     %{
       developers: [%{id: 377, name: "Firaxis Games"}],
       franchises: [%{id: 10, name: "Sid Meier"}],
       id: 866,
       name: "Sid Meier's Civilization V",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "co1n9d",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1n9d.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1n9d.jpg"
       },
       publishers: [
         %{id: 8, name: "2K Games"},
         %{id: 73, name: "Aspyr Media"},
         %{id: 1466, name: "Mastertronic"}
       ],
       release_date: ~U[2010-09-21 00:00:00Z],
       short_description:
         "Sid Meier's Civilization V is a turnbased strategy game where the player leads a civilization from the stoneage all the way to future tech, there is more than one way to win, achieving one of a number of different victory conditions through research, exploration, diplomacy, expansion, economic development, government and military conquest \nYou will face other civilizations, either online as other people or played by the computer, civilization 5 features a advanced diplomacy system when dealing with computer controlled civs or computer controlled city-states.   \n \nIts first expansion pack, Civilization V: Gods & Kings, was released on June 19, 2012 in North America and June 22 internationally. It includes features such as religion, espionage, enhanced naval combat and combat AI, as well as nine new civilizations.[11] \n \nA second expansion pack, Civilization V: Brave New World, was announced on March 15, 2013. It includes features such as international trade routes, a world congress, tourism, great works, as well as nine new civilizations and eight additional wonders. It was released on July 9, 2013 in North America and on July 12, 2013 in the rest of the world."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {403,
     %{
       developers: [%{id: 7263, name: "Team Cherry"}],
       franchises: [],
       id: 14593,
       name: "Hollow Knight",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "llhtucsjtyev2ilhtogq",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/llhtucsjtyev2ilhtogq.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/llhtucsjtyev2ilhtogq.jpg"
       },
       publishers: [%{id: 7263, name: "Team Cherry"}],
       release_date: ~U[2017-02-24 00:00:00Z],
       short_description:
         "Hollow Knight is the first game by Team Cherry, an indie games team comprised of 3 people based in South Australia. \n \nHollow Knight is a challenging, beautiful action adventure game set in the vast, inter-connected underground kingdom of Hallownest. A 2D action game with an emphasis on skill and exploration, Hollow Knight has you fighting a fearsome host of deadly creatures, avoiding intricate traps and solving ancient mysteries as you make your own way through fungal wastes, forests of bone, and ruined underground cities. \n \nThe atmosphere is eerie and sometimes unnerving, but there is a good-hearted core of humour and levity in there too, especially when conversing with all of the weird and wonderful NPCs you’ll find along the way. Hollow Knight has beautiful traditional art, fluid and responsive action, challenging but fair gameplay, and an incredible, bizarre insect world begging to be explored and conquered. \nFeatures \n \n - A beautiful, eerie world of insects and heroes. \n - Traditional 2D animation brings creatures and characters to life. \n - Challenging gameplay that can be difficult but always fair. \n - Fluid and responsive action allows you to flow through combat like water. \n - A collection of challenging “feats” the most skilled players can strive for. \n - Find powerful new abilities and spells on your adventure to grow stronger and open new paths. \n - Speak with a weird, intriguing cast of characters. \n - Explore a vast, connected underground world. \n - Scour the world for hidden secrets – powerful artifacts, piles of riches, and surprising encounters. \n - Go Dream Diving! Venture into the minds of friends and enemies and discover the strange worlds that await within. \n - Head to town to seek advice, purchase new items, and chat with quirky townsfolk. \n - Hidden areas full of the toughest challenges and battles, for expert players. \n - Ancient mysteries hidden about the world waiting to be solved by the most observant investigators."
     }, %{id: 130, name: "Nintendo Switch"}},
    {284,
     %{
       developers: [%{id: 196, name: "Relic Entertainment"}],
       franchises: [],
       id: 1369,
       name: "Company of Heroes 2",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "co1my1",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1my1.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1my1.jpg"
       },
       publishers: [%{id: 112, name: "Sega"}],
       release_date: ~U[2013-06-25 00:00:00Z],
       short_description:
         "Experience the ultimate WWII RTS platform with COH2 and its standalone expansions. This package includes the base game, which you can then upgrade by purchasing The Western Front Armies, Ardennes Assault and/or The British Forces. More info in the \"About This Game\" section below."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {78,
     %{
       developers: [%{id: 377, name: "Firaxis Games"}],
       franchises: [%{id: 10, name: "Sid Meier"}],
       id: 6038,
       name: "Sid Meier's Civilization: Beyond Earth",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "cxkywcrccp1fojoianqc",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/cxkywcrccp1fojoianqc.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/cxkywcrccp1fojoianqc.jpg"
       },
       publishers: [%{id: 8, name: "2K Games"}, %{id: 73, name: "Aspyr Media"}],
       release_date: ~U[2014-10-24 00:00:00Z],
       short_description:
         "Sid Meier's Civilization: Beyond Earth is a new science-fiction-themed entry into the award-winning Civilization series. Set in the future, global events have destabilized the world leading to a collapse of modern society, a new world order and an uncertain future for humanity. As the human race struggles to recover, the re-developed nations focus their resources on deep space travel to chart a new beginning for mankind. \n \nAs part of an expedition sent to find a home beyond Earth, you will write the next chapter for humanity as you lead your people into a new frontier and create a new civilization in space. Explore and colonize an alien planet, research new technologies, amass mighty armies, build incredible Wonders and shape the face of your new world. As you embark on your journey you must make critical decisions. From your choice of sponsor and the make-up of your colony, to the ultimate path you choose for your civilization, every decision opens up new possibilities."
     }, %{id: 14, name: "Mac"}},
    {80,
     %{
       developers: [%{id: 175, name: "Haemimont Games"}],
       franchises: [],
       id: 2595,
       name: "Tropico 4",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"},
         %{id: 36, name: "Xbox Live Arcade"}
       ],
       poster: %{
         id: "q98awllidzxhndyzn4bc",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/q98awllidzxhndyzn4bc.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/q98awllidzxhndyzn4bc.jpg"
       },
       publishers: [
         %{id: 176, name: "FX Interactive"},
         %{id: 23, name: "Feral Interactive"},
         %{id: 783, name: "Kalypso Media"},
         %{id: 3227, name: "Zoo Corporation"}
       ],
       release_date: ~U[2011-08-26 00:00:00Z],
       short_description:
         "Fancy being a dictator? Well this is the ideal time! Build a Tropico and control who and what happens in it. Juggle foreign relations and run a nuclear program! Apply Edicts to make your people happier, or to scare them to obey the rules. Recruit soldiers and have them carry out your will. just make sure to watch out for rebel attacks and even international invasion!"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {49,
     %{
       developers: [%{id: 795, name: "Ninja Theory"}],
       franchises: [],
       id: 1254,
       name: "DmC: Devil May Cry",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "co1n15",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1n15.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1n15.jpg"
       },
       publishers: [%{id: 37, name: "Capcom"}],
       release_date: ~U[2013-01-15 00:00:00Z],
       short_description:
         "In this retelling of Dante's origin story which is set against a contemporary backdrop, DmC Devil May Cry retains the stylish action, fluid combat and self-assured protagonist that have defined the iconic series but inject a more brutal and visceral edge."
     }, %{id: 12, name: "Xbox 360"}},
    {372,
     %{
       developers: [%{id: 1002, name: "Respawn Entertainment"}],
       franchises: [],
       id: 17447,
       name: "Titanfall 2",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "fhbeilnghyhhmjqhinqa",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/fhbeilnghyhhmjqhinqa.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/fhbeilnghyhhmjqhinqa.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2016-10-28 00:00:00Z],
       short_description:
         "Titanfall 2 will deliver a crafted experience that explores the unique bond between man and machine. Playable offline, the single player campaign in Titanfall 2 will let fans step out onto the Frontier as a Militia rifleman with aspirations of becoming an elite Pilot. Stranded behind enemy lines and facing overwhelming odds, players must team up with a veteran Titan to uphold a mission they were never meant to carry out."
     }, %{id: 48, name: "PlayStation 4"}},
    {480,
     %{
       developers: [%{id: 100, name: "Nival Interactive"}],
       franchises: [%{id: 458, name: "Might and Magic"}],
       id: 370,
       name: "Heroes of Might and Magic V",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "co1plb",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1plb.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1plb.jpg"
       },
       publishers: [
         %{id: 104, name: "Ubisoft Entertainment"},
         %{id: 101, name: "Freeverse Software"}
       ],
       release_date: ~U[2006-05-16 00:00:00Z],
       short_description:
         "Witness the amazing evolution of the genre-defining strategy game as it becomes a next-generation phenomenon, melding classic deep fantasy with next-generation visuals and gameplay. \nIn the renowned Might & Magic universe, demon swarms spread chaos over the land in a relentless assault. The fate of the world is at stake and Heroes from a variety of legendary factions must stand up to defend their causes. Live their fate, lead their forces to victory, and unveil the secret goal of the Demon lords."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {475,
     %{
       developers: [%{id: 51, name: "Blizzard Entertainment"}],
       franchises: [%{id: 589, name: "starcraft"}],
       id: 239,
       name: "StarCraft II: Wings of Liberty",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "bgn7cqukcnskka73rwse",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/bgn7cqukcnskka73rwse.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/bgn7cqukcnskka73rwse.jpg"
       },
       publishers: [%{id: 51, name: "Blizzard Entertainment"}],
       release_date: ~U[2010-07-27 00:00:00Z],
       short_description:
         "In the distant future, in the darkest reaches of space, the ghosts of the past whisper your name. You are Jim Raynor, a marshal-turned-rebel on a vigilante crusade to bring down the Dominion and its nefarious leader, Arcturus Mengsk. Haunted by betrayal and remorse, some believe you may have given up the fight. But you have promises to keep… and a need for vengeance that’s long overdue."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {597,
     %{
       developers: [%{id: 852, name: "Platinum Games"}],
       franchises: [],
       id: 115_283,
       name: "Astral Chain",
       platforms: [%{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "co1lzy",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1lzy.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1lzy.jpg"
       },
       publishers: [%{id: 70, name: "Nintendo"}],
       release_date: ~U[2019-08-30 00:00:00Z],
       short_description:
         "ASTRAL CHAIN, a brand new action game from PlatinumGames, is coming exclusively to Nintendo Switch! As part of a police special task force, it’s up to you to fight against mysterious, alien-like creatures who have invaded the world."
     }, %{id: 130, name: "Nintendo Switch"}},
    {381,
     %{
       developers: [%{id: 1641, name: "Hello Games"}],
       franchises: [],
       id: 3225,
       name: "No Man's Sky",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 165, name: "PlayStation VR"}
       ],
       poster: %{
         id: "co1k01",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1k01.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1k01.jpg"
       },
       publishers: [
         %{id: 1641, name: "Hello Games"},
         %{id: 445, name: "505 Games"},
         %{id: 10100, name: "Sony Interactive Entertainment"}
       ],
       release_date: ~U[2016-08-09 00:00:00Z],
       short_description:
         "Inspired by the adventure and imagination that we love from classic science-fiction, No Man's Sky presents you with a galaxy to explore, filled with unique planets and lifeforms, and constant danger and action. \n \nIn No Man's Sky, every star is the light of a distant sun, each orbited by planets filled with life, and you can go to any of them you choose. Fly smoothly from deep space to planetary surfaces, with no loading screens, and no limits. In this infinite procedurally generated universe, you'll discover places and creatures that no other players have seen before - and perhaps never will again."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {488,
     %{
       developers: [%{id: 38, name: "Ubisoft Montreal"}],
       franchises: [],
       id: 798,
       name: "Myst IV: Revelation",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 11, name: "Xbox"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "aptf5j7ijwfxcjlmk3n7",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/aptf5j7ijwfxcjlmk3n7.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/aptf5j7ijwfxcjlmk3n7.jpg"
       },
       publishers: [%{id: 104, name: "Ubisoft Entertainment"}],
       release_date: ~U[2004-09-28 00:00:00Z],
       short_description:
         "Myst IV: Revelation is the fourth installment in the Myst computer game series, developed and published by Ubisoft. Like Myst III: Exile, Revelation combines pre-rendered graphics with digital video, but also features real-time 3D effects for added realism.\n\nThe plot of Revelation ties up loose ends from the original Myst. The player is summoned by Atrus, a man who creates links to other worlds known as Ages by writing special linking books. Almost twenty years earlier, Atrus' two sons nearly destroyed all of his linking books and were imprisoned; Atrus now wishes to see if his sons' imprisonment has reformed them. The player ends up traveling to each brother's prison, in an effort to recover Atrus' daughter Yeesha from the brothers' plot."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {489,
     %{
       developers: [%{id: 564, name: "Presto Studios"}],
       franchises: [],
       id: 797,
       name: "Myst III: Exile",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 8, name: "PlayStation 2"},
         %{id: 11, name: "Xbox"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "tcenzw3o9hkckie4mbje",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/tcenzw3o9hkckie4mbje.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/tcenzw3o9hkckie4mbje.jpg"
       },
       publishers: [%{id: 104, name: "Ubisoft Entertainment"}],
       release_date: ~U[2001-05-07 00:00:00Z],
       short_description:
         "MYST III: EXILE introduces a new villain Saavedro, who seeks revenge when he finds out his homeland was destroyed by Atrus' sons. The player must track the villain through several surrealistic Ages, navigating puzzles to uncover the truth behind this new adversary. Only then can disaster be averted to choose who was right and who was wrong. \n\nSaavedro is played by Academy Award nominee Brad Dourif (One Flew Over the Cuckoo's Nest)."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {47,
     %{
       developers: [%{id: 2, name: "BioWare"}],
       franchises: [],
       id: 76,
       name: "Dragon Age: Origins",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1n02",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1n02.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1n02.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2009-11-03 00:00:00Z],
       short_description:
         "You are a Grey Warden, one of the last of a legendary order of guardians. With the return of mankind's ancient foe and the kingdom engulfed in civil war, you have been chosen by fate to unite the shattered lands and slay the archdemon once and for all."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {55,
     %{
       developers: [%{id: 908, name: "CD Projekt RED"}],
       franchises: [%{id: 452, name: "The Witcher"}],
       id: 1942,
       name: "The Witcher 3: Wild Hunt",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "tri1c6vbydeosoqajwt1",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/tri1c6vbydeosoqajwt1.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/tri1c6vbydeosoqajwt1.jpg"
       },
       publishers: [
         %{id: 50, name: "WB Games"},
         %{id: 248, name: "Bandai Namco Entertainment"},
         %{id: 3119, name: "cdp.pl"},
         %{id: 157, name: "1C Company"},
         %{id: 1217, name: "Spike ChunSoft"}
       ],
       release_date: ~U[2015-05-19 00:00:00Z],
       short_description:
         "The Witcher: Wild Hunt is a story-driven, next-generation open world role-playing game set in a visually stunning fantasy universe full of meaningful choices and impactful consequences. In The Witcher you play as the professional monster hunter, Geralt of Rivia, tasked with finding a child of prophecy in a vast open world rich with merchant cities, viking pirate islands, dangerous mountain passes, and forgotten caverns to explore."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {274,
     %{
       developers: [%{id: 15, name: "2K Marin"}],
       franchises: [],
       id: 244,
       name: "The Bureau: XCOM Declassified",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "co1ncc",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ncc.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ncc.jpg"
       },
       publishers: [%{id: 8, name: "2K Games"}],
       release_date: ~U[2013-08-06 00:00:00Z],
       short_description:
         "The year is 1962 and the Cold War has the nation gripped by fear. A top-secret government unit called The Bureau begins investigating a series of mysterious attacks by an enemy more powerful than communism. As agent Carter, call the shots, pull the trigger and lead your squad in a gripping third-person tactical shooter set within a covert war to protect humanity from an otherworldly enemy."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {77,
     %{
       developers: [%{id: 111, name: "The Creative Assembly"}],
       franchises: [%{id: 977, name: "Total War"}],
       id: 2359,
       name: "Total War: Rome II",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "co1qs5",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qs5.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qs5.jpg"
       },
       publishers: [%{id: 112, name: "Sega"}],
       release_date: ~U[2013-09-03 00:00:00Z],
       short_description:
         "Encompassing one of the best-known periods in world history, Total War: Rome II will combines turn-based campaigns with large, cinematic real-time battles. \n \nBecome the world's first superpower and command the most incredible and vast war machine of the Ancient world. Dominate the enemies of your glorious empire by military, economic and political means. Your rise will bring admiration from your followers but will also attract greed and jealousy, even from your closest allies. Will betrayal strike you down, or will you be the first to turn on old friends? How much are you ready to sacrifice for your vision of Rome? Will you fight to save the Republic, or plot to rule alone as Dictator – as Emperor?"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {48,
     %{
       developers: [%{id: 94, name: "EA Digital Illusions CE"}],
       franchises: [],
       id: 343,
       name: "Battlefield 3",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "co1n0g",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1n0g.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1n0g.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2011-10-25 00:00:00Z],
       short_description:
         "In Battlefield 3, players step into the role of the elite U.S. Marines. As the first boots on the ground, players will experience heart-pounding missions across diverse locations including Paris, Tehran and New York. As a U.S. Marine in the field, periods of tension and anticipation are punctuated by moments of complete chaos. As bullets whiz by, as walls crumble, as explosions force players to the ground, the battlefield feels more alive and interactive than ever before."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {463,
     %{
       developers: [%{id: 37, name: "Capcom"}],
       franchises: [],
       id: 6490,
       name: "Chip 'n Dale Rescue Rangers",
       platforms: [%{id: 18, name: "Nintendo Entertainment System (NES)"}],
       poster: %{
         id: "co1qni",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qni.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qni.jpg"
       },
       publishers: [%{id: 37, name: "Capcom"}],
       release_date: ~U[1990-06-08 00:00:00Z],
       short_description:
         "Chip 'n Dale Rescue Rangers (チップとデールの大作戦 Chippu to Dēru no Daisakusen?, lit. \"Chip 'n Dale's Mission\") is a platformer video game developed and published by Capcom based on the Disney animated series of the same name. Originally released for the Nintendo Entertainment System in Japan and North America in 1990, it came to Europe the next year, and was ported to the Nintendo PlayChoice-10 arcade system. It sold approximately 1.2 million copies worldwide."
     }, %{id: 18, name: "Nintendo Entertainment System (NES)"}},
    {102,
     %{
       developers: [%{id: 4133, name: "11 bit studios"}],
       franchises: [],
       id: 7706,
       name: "This War of Mine",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1ncf",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ncf.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ncf.jpg"
       },
       publishers: [%{id: 4133, name: "11 bit studios"}],
       release_date: ~U[2014-11-14 00:00:00Z],
       short_description:
         "In This War Of Mine you do not play as an elite soldier, rather a group of civilians trying to survive in a besieged city; struggling with lack of food, medicine and constant danger from snipers and hostile scavengers. The game provides an experience of war seen from an entirely new angle. \n\nThe pace of This War of Mine is imposed by the day and night cycle. During the day snipers outside stop you from leaving your refuge, so you need to focus on maintaining your hideout: crafting, trading and taking care of your survivors. At night, take one of your civilians on a mission to scavenge through a set of unique locations for items that will help you stay alive. \n\nMake life-and-death decisions driven by your conscience. Try to protect everybody from your shelter or sacrifice some of them for longer-term survival. During war, there are no good or bad decisions; there is only survival. The sooner you realize that, the better."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {592,
     %{
       developers: [%{id: 1225, name: "Ubisoft San Francisco"}],
       franchises: [%{id: 28, name: "South Park"}],
       id: 11161,
       name: "South Park: The Fractured But Whole",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "uaazm99tayusmuuzl1gr",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/uaazm99tayusmuuzl1gr.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/uaazm99tayusmuuzl1gr.jpg"
       },
       publishers: [%{id: 104, name: "Ubisoft Entertainment"}],
       release_date: ~U[2017-10-17 00:00:00Z],
       short_description:
         "Players will once again assume the role of the New Kid, and join South Park favorites Stan, Kyle, Kenny and Cartman in a new hilarious and outrageous adventure. This time, players will delve into the crime-ridden underbelly of South Park with Coon and Friends. \n \nThis dedicated group of crime fighters was formed by Eric Cartman whose superhero alter-ego, The Coon, is half man, half raccoon. As the New Kid, players will join Mysterion, Toolshed, Human Kite, Mosquito, Mint Berry Crunch and a host of others to battle the forces of evil while Coon strives to make his team the most beloved superheroes in history."
     }, %{id: 130, name: "Nintendo Switch"}},
    {126,
     %{
       developers: [%{id: 37, name: "Capcom"}],
       franchises: [],
       id: 19562,
       name: "Resident Evil 7: Biohazard",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1r3t",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r3t.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r3t.jpg"
       },
       publishers: [%{id: 37, name: "Capcom"}],
       release_date: ~U[2017-01-24 00:00:00Z],
       short_description:
         "Resident Evil 7: Biohazard is a survival horror video game developed by Capcom, for Microsoft Windows, PlayStation 4, and Xbox One, with the PlayStation 4 version including full PlayStation VR support."
     }, %{id: 48, name: "PlayStation 4"}},
    {108,
     %{
       developers: [%{id: 6548, name: "Urban Games"}],
       franchises: [],
       id: 9447,
       name: "Train Fever",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "aqhgyqifuxqoyvlnouvu",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/aqhgyqifuxqoyvlnouvu.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/aqhgyqifuxqoyvlnouvu.jpg"
       },
       publishers: [
         %{id: 6549, name: "Good Shepherd Entertainment"},
         %{id: 1552, name: "Astragon"}
       ],
       release_date: ~U[2014-09-04 00:00:00Z],
       short_description:
         "Train Fever is a railroad-focused business simulation game. In other words, it's a modern-day Transport Tycoon with procedural content and a sophisticated city simulation.\n\nIt’s the year 1850, and there are great times ahead! Establish a transport company and be its manager. Build infrastructure such as railways and stations, purchase transportation vehicles and manage lines. Fulfil the people’s needs and watch cities evolve dynamically. Train Fever runs on an engine specifically developed for this game. The engine has a great innovative scope and is specialized in procedural content and urban simulation. A key point is the fact that there is no grid that game objects have to be aligned to, allowing for a great degree of freedom."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {141,
     %{
       developers: [%{id: 1005, name: "Klei Entertainment"}],
       franchises: [],
       id: 2129,
       name: "Mark of the Ninja",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "co1hxm",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1hxm.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1hxm.jpg"
       },
       publishers: [%{id: 1010, name: "Microsoft Studios"}],
       release_date: ~U[2012-09-07 00:00:00Z],
       short_description:
         "Mark of the Ninja is a side-scrolling action stealth video game developed by Klei Entertainment and published by Microsoft Studios. It was announced on February 28, 2012 and later released for the Xbox 360 via Xbox Live Arcade on September 7, 2012. A Microsoft Windows version was released on October 16, 2012. It follows the story of a nameless ninja in the present day, and features a themed conflict between ancient ninja tradition and modern technology. Cutscenes for the game are rendered in Saturday morning cartoon animation style."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {572,
     %{
       developers: [%{id: 7466, name: "Paradox Development Studio"}],
       franchises: [],
       id: 102_060,
       name: "Imperator: Rome",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1ma9",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ma9.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ma9.jpg"
       },
       publishers: [%{id: 517, name: "Paradox Interactive"}],
       release_date: ~U[2019-04-25 00:00:00Z],
       short_description:
         "\"Paradox Development Studio returns to ancient history with Imperator: Rome, a new title set around the growth of Roman power in a threatening Mediterranean. Unify Italy and then the world under the eagles of your legions. Or rule an Eastern monarchy with claims to the mantle of Alexander. Slaves, barbarians and war elephants bring the distant past to life in Imperator: Rome. Can you be a Caesar?\""
     }, %{id: 14, name: "Mac"}},
    {583,
     %{
       developers: [%{id: 2055, name: "Clover Studio"}],
       franchises: [],
       id: 20744,
       name: "Ōkami HD",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "q9bzzi34vsxjqvxnfxr6",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/q9bzzi34vsxjqvxnfxr6.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/q9bzzi34vsxjqvxnfxr6.jpg"
       },
       publishers: [%{id: 11900, name: "Capcom Co., Ltd."}],
       release_date: ~U[2012-10-30 00:00:00Z],
       short_description:
         "Six years after the release of the original, Okami finally graces a new generation of consoles on the PS3 as a downloadable title via the PlayStation Network. With full, native 1080p graphics, Okami HD breathes new life into the classic hit. Okami HD also takes full advantage of the PS®Move motion controller, providing players with a new way to play. With newly enhanced visuals, optional Move controls, and the ability to earn trophies, Okami HD is the definitive version to own!"
     }, %{id: 130, name: "Nintendo Switch"}},
    {504,
     %{
       developers: [%{id: 151, name: "Simtex"}],
       franchises: [],
       id: 68,
       name: "Master of Orion II: Battle at Antares",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "u1y5ihod8jcau7aicqrt",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/u1y5ihod8jcau7aicqrt.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/u1y5ihod8jcau7aicqrt.jpg"
       },
       publishers: [%{id: 152, name: "MicroProse"}, %{id: 130, name: "MacSoft Games"}],
       release_date: ~U[1996-10-31 00:00:00Z],
       short_description:
         "Master of Orion 2 also known as MOO2 is considered the classic 4x turn based strategy game set in space. The game has a kind of cult status and even by to days standards is still only matched in game play by very few of its competitors."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {591,
     %{
       developers: [%{id: 6209, name: "Mobius Digital"}],
       franchises: [],
       id: 11737,
       name: "Outer Wilds",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 49, name: "Xbox One"}],
       poster: %{
         id: "co1i2e",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1i2e.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1i2e.jpg"
       },
       publishers: [%{id: 11662, name: "Annapurna Interactive"}],
       release_date: ~U[2019-05-29 00:00:00Z],
       short_description:
         "Outer Wilds is an open world mystery about a solar system trapped in an endless time loop. \n \nWelcome to the Space Program! \nYou’re the newest recruit of Outer Wilds Ventures, a fledgling space program searching for answers in a strange, constantly evolving solar system. \n \nMysteries of the Solar System... \nWhat lurks in the heart of the ominous Dark Bramble? Who built the alien ruins on the Moon? Can the endless time loop be stopped? Answers await you in the most dangerous reaches of space."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {457,
     %{
       developers: [%{id: 856, name: "Unknown Worlds Entertainment"}],
       franchises: [],
       id: 9254,
       name: "Subnautica",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 162, name: "Oculus VR"}
       ],
       poster: %{
         id: "co1iqw",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1iqw.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1iqw.jpg"
       },
       publishers: [
         %{id: 856, name: "Unknown Worlds Entertainment"},
         %{id: 11262, name: "Gearbox Publishing"}
       ],
       release_date: ~U[2018-01-23 00:00:00Z],
       short_description:
         "Subnautica is an open world, underwater exploration and adventure game currently under construction at Unknown Worlds, the independent developer behind Natural Selection 2."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {113,
     %{
       developers: [%{id: 854, name: "Playdead"}],
       franchises: [],
       id: 7342,
       name: "INSIDE",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 39, name: "iOS"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "olfzuujqldnwa68vifyv",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/olfzuujqldnwa68vifyv.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/olfzuujqldnwa68vifyv.jpg"
       },
       publishers: [%{id: 854, name: "Playdead"}],
       release_date: ~U[2016-06-29 00:00:00Z],
       short_description:
         "An atmospheric 2D side-scroller in which, hunted and alone, a boy finds himself drawn into the center of a dark project and struggles to preserve his identity."
     }, %{id: 48, name: "PlayStation 4"}},
    {123,
     %{
       developers: [%{id: 7097, name: "Thunder Lotus Games"}],
       franchises: [],
       id: 14147,
       name: "Jotun",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1jvo",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1jvo.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1jvo.jpg"
       },
       publishers: [%{id: 7097, name: "Thunder Lotus Games"}],
       release_date: ~U[2015-09-29 00:00:00Z],
       short_description:
         "Jotun is a hand-drawn action-exploration game set in Norse mythology. In Jotun, you play Thora, a Norse warrior who has died an inglorious death and must prove herself to the Gods to enter Valhalla."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {106,
     %{
       developers: [%{id: 647, name: "Related Designs"}, %{id: 646, name: "Blue Byte Software"}],
       franchises: [],
       id: 2959,
       name: "Anno 2070",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "co1niy",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1niy.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1niy.jpg"
       },
       publishers: [%{id: 104, name: "Ubisoft Entertainment"}],
       release_date: ~U[2011-11-17 00:00:00Z],
       short_description:
         "Anno 2070 is a city-building and economic simulation game, with real-time strategy elements. It is the 5th game of the Anno series. It was released on 17 November 2011, and was co-developed by the German studios Related Designs and Ubisoft Blue Byte, and published by Ubisoft. Anno 2070 requires Uplay to operate."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {122,
     %{
       developers: [%{id: 894, name: "Dontnod Entertainment"}],
       franchises: [],
       id: 7599,
       name: "Life is Strange",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"},
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1r8e",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r8e.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r8e.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}, %{id: 23, name: "Feral Interactive"}],
       release_date: ~U[2015-01-30 00:00:00Z],
       short_description:
         "Reunited with her former friend Chloe, the pair will attempt to uncover the uncomfortable truth behind the mysterious disappearance of fellow student Rachel Amber. With high quality production values and a unique hand-drawn art style, LIFE IS STRANGE is a compelling, story-driven experience where choice and consequence play a key role in how the narrative unfolds. But there is a twist. At the beginning of the game Max discovers she has a remarkable power… the ability to rewind time. In LIFE IS STRANGE the player has the power to affect the game’s narrative and also change the course of history itself."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {153,
     %{
       developers: [%{id: 1380, name: "Red Barrels"}],
       franchises: [],
       id: 1910,
       name: "Outlast",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "co1ql4",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ql4.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ql4.jpg"
       },
       publishers: [%{id: 1380, name: "Red Barrels"}],
       release_date: ~U[2013-09-04 00:00:00Z],
       short_description:
         "In the remote mountains of Colorado, horrors wait inside Mount Massive Asylum. A long-abandoned home for the mentally ill, recently re-opened by the “research and charity” branch of the transnational Murkoff Corporation, has been operating in strict secrecy… until now. \n \nActing on a tip from an inside source, independent journalist Miles Upshur breaks into the facility, and what he discovers walks a terrifying line between science and religion, nature and something else entirely. Once inside, his only hope of escape lies with the terrible truth at the heart of Mount Massive."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {598,
     %{
       developers: [%{id: 305, name: "Remedy Entertainment"}],
       franchises: [],
       id: 103_329,
       name: "Control",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1r6j",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r6j.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r6j.jpg"
       },
       publishers: [%{id: 445, name: "505 Games"}],
       release_date: ~U[2019-08-27 00:00:00Z],
       short_description:
         "After a secretive agency in New York is invaded by an otherworldly threat, you become the new Director struggling to regain Control. From developer Remedy Entertainment, this supernatural 3rd person action-adventure will challenge you to master the combination of supernatural abilities, modifiable loadouts and reactive environments while fighting through a deep and unpredictable world. \n \nControl is Jesse Faden’s story and her personal search for answers as she grows into the role of the Director. The world of Control has its own story, as do the allies Jesse meets along the way. Jesse works with other Bureau agents and discovers strange experiments and secrets."
     }, %{id: 48, name: "PlayStation 4"}},
    {487,
     %{
       developers: [%{id: 326, name: "Cyan Worlds"}, %{id: 432, name: "Beenox"}],
       franchises: [],
       id: 8475,
       name: "Myst V: End of Ages",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "dsxfuqzr1wszdu8ixsvd",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/dsxfuqzr1wszdu8ixsvd.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/dsxfuqzr1wszdu8ixsvd.jpg"
       },
       publishers: [%{id: 326, name: "Cyan Worlds"}],
       release_date: ~U[2005-09-20 00:00:00Z],
       short_description:
         "Myst V: End of Ages is a 2005 adventure video game, and the fifth and final installment in the Myst series. As in previous games in the series, End of Ages's gameplay consists of navigating worlds known as \"Ages\" via the use of special books and items which act as portals. On each Age, the player solves puzzles and discovers story clues hidden in the Ages or written down in diaries and journals. The player's actions in the game decide the fate of the ancient D'ni civilization."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {490,
     %{
       developers: [%{id: 111, name: "The Creative Assembly"}],
       franchises: [%{id: 977, name: "Total War"}],
       id: 438,
       name: "Rome: Total War",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 39, name: "iOS"}
       ],
       poster: %{
         id: "co1os0",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1os0.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1os0.jpg"
       },
       publishers: [
         %{id: 66, name: "Activision"},
         %{id: 112, name: "Sega"},
         %{id: 23, name: "Feral Interactive"}
       ],
       release_date: ~U[2004-09-22 00:00:00Z],
       short_description:
         "Set during the rule of the late Roman Republic and the early Roman Empire, Rome: Total War is a real-time tactics and turn-based strategy game that takes place across Europe, North Africa and the Near East. The player assumes control of one of three Roman families with eight other factions playable outside the main campaign. The main goal of the campaign is to become emperor of Rome by conquering fifty provinces with the support of the people before capturing Rome itself although a short campaign is also available wherein success depends on besting other factions in a race to seize control of 15 provinces."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {112,
     %{
       developers: [%{id: 93, name: "Square Enix 1st Production Department"}],
       franchises: [%{id: 4, name: "Final Fantasy"}],
       id: 359,
       name: "Final Fantasy XV",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "go4jc0ilxqmwib8yjndn",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/go4jc0ilxqmwib8yjndn.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/go4jc0ilxqmwib8yjndn.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}],
       release_date: ~U[2016-11-29 00:00:00Z],
       short_description:
         "Final Fantasy XV is an action role-playing video game being developed and published by Square Enix for the PlayStation 4 and Xbox One. It is the fifteenth main installment in the Final Fantasy series, and forms part of the Fabula Nova Crystallis subseries, which also includes Final Fantasy XIII and Final Fantasy Type-0. \n \nOriginally a spin-off titled Final Fantasy Versus XIII exclusive to the PlayStation 3, it is a heavy departure from previous games, providing a darker atmosphere that focuses on more realistic human characters than previous entries. The game features an open-world environment and action-based battle system similar to the Kingdom Hearts series and Type-0, incorporating the ability to switch weapons and other elements such as vehicle travel and camping."
     }, %{id: 48, name: "PlayStation 4"}},
    {142,
     %{
       developers: [%{id: 19, name: "Arkane Studios"}],
       franchises: [],
       id: 533,
       name: "Dishonored",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1qqr",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qqr.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qqr.jpg"
       },
       publishers: [%{id: 28, name: "Bethesda Softworks LLC"}],
       release_date: ~U[2012-10-09 00:00:00Z],
       short_description:
         "Dishonored is an immersive first-person action game that casts you as a supernatural assassin driven by revenge. With Dishonored’s flexible combat system, creatively eliminate your targets as you combine the supernatural abilities, weapons and unusual gadgets at your disposal. Pursue your enemies under the cover of darkness or ruthlessly attack them head on with weapons drawn. The outcome of each mission plays out based on the choices you make."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {407,
     %{
       developers: [%{id: 7902, name: "Nintendo EPD"}],
       franchises: [%{id: 24, name: "Mario Bros."}],
       id: 26758,
       name: "Super Mario Odyssey",
       platforms: [%{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "co1mxf",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mxf.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mxf.jpg"
       },
       publishers: [
         %{id: 2850, name: "Nintendo of America"},
         %{id: 4034, name: "Nintendo of Europe"},
         %{id: 70, name: "Nintendo"}
       ],
       release_date: ~U[2017-10-27 00:00:00Z],
       short_description:
         "The game has Mario leaving the Mushroom Kingdom to reach an unknown open world-like setting, like Super Mario 64 and Super Mario Sunshine."
     }, %{id: 130, name: "Nintendo Switch"}},
    {494,
     %{
       developers: [%{id: 1056, name: "Piranha Bytes"}],
       franchises: [],
       id: 2261,
       name: "Gothic",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "co1nov",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nov.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nov.jpg"
       },
       publishers: [
         %{id: 1058, name: "Xicat Interactive"},
         %{id: 753, name: "Nordic Games Publishing"},
         %{id: 469, name: "JoWooD Entertainment AG"},
         %{id: 1057, name: "Egmont Interactive"}
       ],
       release_date: ~U[2001-03-15 00:00:00Z],
       short_description:
         "Gothic is a single-player action role-playing video game for Windows developed by the German company Piranha Bytes. It was first released in Germany on March 15, 2001, followed by the English North American release eight months later on November 23, 2001, and the Polish release on March 28, 2002. \n \nGothic has been well received by critics, scoring an average of 80% and 81/100 on Game Rankings' and Metacritic's aggregates, respectively. Reviewers credited the game for its story, complex interaction with other in-game characters, and graphics, but criticized it for the difficult control scheme and high system requirements."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {389,
     %{
       developers: [%{id: 834, name: "Insomniac Games"}],
       franchises: [%{id: 124, name: "Marvel"}, %{id: 151, name: "Spider-Man"}],
       id: 19565,
       name: "Marvel's Spider-Man",
       platforms: [%{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1r77",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r77.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r77.jpg"
       },
       publishers: [%{id: 10100, name: "Sony Interactive Entertainment"}],
       release_date: ~U[2018-09-07 00:00:00Z],
       short_description:
         "Starring the world’s most iconic Super Hero, Spider-Man features the acrobatic abilities, improvisation and web-slinging that the wall-crawler is famous for, while also introducing elements never-before-seen in a Spider-Man game. From traversing with parkour and utilizing the environment, to new combat and blockbuster set pieces, it’s Spider-Man unlike any you’ve played before."
     }, %{id: 48, name: "PlayStation 4"}},
    {114,
     %{
       developers: [%{id: 748, name: "Double Eleven"}, %{id: 854, name: "Playdead"}],
       franchises: [],
       id: 1331,
       name: "Limbo",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 34, name: "Android"},
         %{id: 36, name: "Xbox Live Arcade"},
         %{id: 39, name: "iOS"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 46, name: "PlayStation Vita"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1qrs",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qrs.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qrs.jpg"
       },
       publishers: [%{id: 53, name: "Microsoft Game Studios"}, %{id: 854, name: "Playdead"}],
       release_date: ~U[2010-07-21 00:00:00Z],
       short_description:
         "Limbo is a black and white puzzle-platforming adventure. Play the role of a young boy traveling through an eerie and treacherous world in an attempt to discover the fate of his sister. Limbo's design is an example of gaming as an art form. Short and sweet, doesn't overstay its welcome. Puzzles are challenging and fun, not illogical and frustrating."
     }, %{id: 48, name: "PlayStation 4"}},
    {419,
     %{
       developers: [%{id: 1447, name: "Subset Games"}],
       franchises: [],
       id: 27117,
       name: "Into the Breach",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "ntjvv6crd4n66steokv5",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/ntjvv6crd4n66steokv5.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/ntjvv6crd4n66steokv5.jpg"
       },
       publishers: [%{id: 1447, name: "Subset Games"}],
       release_date: ~U[2018-02-27 00:00:00Z],
       short_description:
         "The remnants of human civilization are threatened by gigantic creatures breeding beneath the earth. You must control powerful mechs from the future to hold off this alien threat. Each attempt to save the world presents a new randomly generated challenge in this turn-based strategy game from the makers of FTL."
     }, %{id: 14, name: "Mac"}},
    {139,
     %{
       developers: [%{id: 5152, name: "Bithell Games"}],
       franchises: [],
       id: 2291,
       name: "Thomas Was Alone",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 14, name: "Mac"},
         %{id: 34, name: "Android"},
         %{id: 41, name: "Wii U"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 46, name: "PlayStation Vita"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1r1u",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r1u.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r1u.jpg"
       },
       publishers: [%{id: 5152, name: "Bithell Games"}],
       release_date: ~U[2012-07-24 00:00:00Z],
       short_description:
         "Guide a group of rectangles through a series of obstacles, using their different skills together to get to the end of each environment."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {506,
     %{
       developers: [%{id: 175, name: "Haemimont Games"}],
       franchises: [],
       id: 9691,
       name: "Tzar: The Burden of the Crown",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "s8pufjquip0wyaahpjzz",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/s8pufjquip0wyaahpjzz.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/s8pufjquip0wyaahpjzz.jpg"
       },
       publishers: [
         %{id: 267, name: "TalonSoft"},
         %{id: 157, name: "1C Company"},
         %{id: 176, name: "FX Interactive"},
         %{id: 139, name: "Take-Two Interactive"}
       ],
       release_date: ~U[2000-01-27 00:00:00Z],
       short_description:
         "Tzar: The Burden of the Crown is a real-time strategy game for the PC published by Take-Two Interactive and developed by the Bulgarian game developer company Haemimont Games.\nThe gameplay is set up in a fictional medieval age. The basic goal is to conquer the neighbouring kingdoms and destroy all traces of them, or destroy their castles, depending on selected playing mode. There are many different buildings and characters you can produce, each depending on which of the 3 races you choose to be: European, Asian or Arabian. The main differences are the types of special buildings available, and the types of troops you can make. There is also a campaign option for single players in which the player must complete specific goals, such as destroying an enemy force, or protecting a citadel from attack. The game also includes a map editor where players can create their own map to play on with strategic rivers, forests, and resources to build their armies with."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {155,
     %{
       developers: [%{id: 2297, name: "ColdWood Interactive"}],
       franchises: [],
       id: 11170,
       name: "Unravel",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "tr5irtvxtt0b8bbyg9lq",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/tr5irtvxtt0b8bbyg9lq.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/tr5irtvxtt0b8bbyg9lq.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2016-02-09 00:00:00Z],
       short_description:
         "Unravel is a game about Yarny, a tiny character born from a single thread. Yarny embarks on a big adventure into the nature, inspired by the beauty of Northern Scandinavia. Without any spoken words, the character will have to solve puzzles and use tools to overcome tough challenges. All this, in order to find memories of his lost family. \nOnly Yarny can be the bond that ties everything together in the end."
     }, %{id: 48, name: "PlayStation 4"}},
    {151,
     %{
       developers: [%{id: 290, name: "IO Interactive"}],
       franchises: [],
       id: 530,
       name: "Hitman: Absolution",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "co1qrc",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qrc.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qrc.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}],
       release_date: ~U[2012-11-20 00:00:00Z],
       short_description:
         "Hitman: Absolution follows the Original Assassin undertaking his most personal contract to date. Betrayed by the Agency and hunted by the police, Agent 47 finds himself pursuing redemption in a corrupt and twisted world. \n \nShowcasing Io-Interactive’s new proprietary Glacier 2 technology, the game has been built from the ground up, boasting a cinematic story, distinctive art direction and highly original game design, Hitman Absolution combines much loved classic gameplay with completely new gameplay features for the Hitman franchise."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {518,
     %{
       developers: [%{id: 180, name: "Mythos Games"}],
       franchises: [],
       id: 26,
       name: "X-COM: Apocalypse",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 13, name: "PC DOS"}],
       poster: %{
         id: "co1ngn",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ngn.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ngn.jpg"
       },
       publishers: [%{id: 152, name: "MicroProse"}],
       release_date: ~U[1997-06-30 00:00:00Z],
       short_description:
         "Your mission, as X-COM Commander, is to combat alien aggression and uncover their deadly intentions. But Beware! Alien infiltration into the city and its politics could see you under fire from criminal gangs, religious sects, and even the police! Alien fleets fill the skies, creatures terrorise the city, chaos reigns... Welcome to the war, welcome to the Apocalypse."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {146,
     %{
       developers: [%{id: 859, name: "Runic Games"}],
       franchises: [],
       id: 1337,
       name: "Torchlight II",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1its",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1its.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1its.jpg"
       },
       publishers: [%{id: 859, name: "Runic Games"}],
       release_date: ~U[2012-09-20 00:00:00Z],
       short_description:
         "Torchlight II features randomly generated dungeons and numerous types of monsters to fight for loot. Torchlight II is an action RPG as its predecessor, but features overland areas with multiple hub towns, and a longer campaign. Players are able to customize character appearance with choice of sex, face, hair style and hair color. Additionally, several elements from the first game return, such as pets and fishing. \nThe game features four playable character classes. Each class has 3 skill trees to choose from which enable customization within each class."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {529,
     %{
       developers: [],
       franchises: [],
       id: 7700,
       name: "Parkan: The Imperial Chronicles",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "rb9tfjev5skkjuiqevdz",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/rb9tfjev5skkjuiqevdz.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/rb9tfjev5skkjuiqevdz.jpg"
       },
       publishers: [],
       release_date: ~U[1997-09-01 00:00:00Z],
       short_description:
         "Legendary game from the Golden age of Russian gaming industry! Hybrid gameplay combines elements of space simulator, shooter, strategy and RPG. Explore the outer space, colonize planets, negotiate with clans of robots, fight in space battles and become mercenary, trader or pirate!"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {152,
     %{
       developers: [
         %{id: 823, name: "United Front Games"},
         %{id: 824, name: "Square Enix London Studios"}
       ],
       franchises: [%{id: 445, name: "Sleeping Dogs"}],
       id: 1267,
       name: "Sleeping Dogs",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1ij2",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ij2.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ij2.jpg"
       },
       publishers: [
         %{id: 248, name: "Bandai Namco Entertainment"},
         %{id: 26, name: "Square Enix"}
       ],
       release_date: ~U[2012-08-13 00:00:00Z],
       short_description:
         "Wei Shen, an young officer working for the San Francisco Police Department gets tasked to go back to his hometown of Hong Kong. In Hong Kong Wei is assigned to the Hong Kong Police Department, in a effort to take down the \"Sun on Yee\" Wei goes undercover in the triad to gather information and take them down, But the police soon become worried that he is getting attached to his \"Friends\" such as Jackie Ma. In this journey of Betrayal and High stakes, Will Wei become a \"Red Pole\" and join the high ranks of the Triads or be discovered by them and buried alive?"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {161,
     %{
       developers: [%{id: 19, name: "Arkane Studios"}],
       franchises: [],
       id: 19531,
       name: "Prey",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "pzgwdpvoww1nrlkv7d5x",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/pzgwdpvoww1nrlkv7d5x.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/pzgwdpvoww1nrlkv7d5x.jpg"
       },
       publishers: [%{id: 28, name: "Bethesda Softworks LLC"}],
       release_date: ~U[2017-05-05 00:00:00Z],
       short_description:
         "In Prey, you awaken aboard Talos I, a space station orbiting the moon in the year 2032. You are the key subject of an experiment meant to alter humanity forever – but things have gone terribly wrong. The space station has been overrun by hostile aliens and you are now being hunted. As you dig into the dark secrets of Talos I and your own past, you must survive using the tools found on the station, your wits, weapons, and mind-bending abilities."
     }, %{id: 48, name: "PlayStation 4"}},
    {599,
     %{
       developers: [%{id: 741, name: "Toys for Bob"}],
       franchises: [%{id: 1166, name: "Spyro the Dragon"}],
       id: 87683,
       name: "Spyro Reignited Trilogy",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1ltb",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ltb.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ltb.jpg"
       },
       publishers: [%{id: 66, name: "Activision"}],
       release_date: ~U[2018-11-13 00:00:00Z],
       short_description: "The first three Spyro the Dragon games remastered in HD."
     }, %{id: 130, name: "Nintendo Switch"}},
    {350,
     %{
       developers: [%{id: 5212, name: "Campo Santo"}],
       franchises: [],
       id: 9730,
       name: "Firewatch",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1m35",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1m35.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1m35.jpg"
       },
       publishers: [%{id: 5213, name: "Panic"}],
       release_date: ~U[2016-02-09 00:00:00Z],
       short_description:
         "Firewatch is a mystery set in the woods of Wyoming, where your only emotional lifeline is the person on the other end of a handheld radio. You play as a man named Henry who has retreated from his messy life to work as a fire lookout in the wilderness. Perched high atop a mountain, it’s your job to look for smoke and keep the wilderness safe. An especially hot and dry summer has everyone on edge. Your supervisor, a woman named Delilah, is available to you at all times over a small, handheld radio -- and is your only contact with the world you’ve left behind. But when something strange draws you out of your lookout tower and into the world, you’ll explore a wild and unknown environment, facing questions and making interpersonal choices that can build or destroy the only meaningful relationship you have."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {144,
     %{
       developers: [%{id: 27, name: "Eidos Montréal"}],
       franchises: [],
       id: 43,
       name: "Deus Ex: Human Revolution",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1o8e",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1o8e.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1o8e.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}, %{id: 23, name: "Feral Interactive"}],
       release_date: ~U[2011-08-23 00:00:00Z],
       short_description:
         "In Deus Ex: Human Revolution you play Adam Jensen, a security specialist, handpicked to oversee the defense of one of America's most experimental biotechnology firms. But when a black ops team breaks in and kills the scientists you were hired to protect, everything you thought you knew about your job changes. At a time when scientific advancements are routinely turning athletes, soldiers and spies into super-enhanced beings, someone is working very hard to ensure mankind's evolution follows a particular path. You need to discover why - because the decisions you take and the choices you make will be the only things that can determine mankind's future."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {526,
     %{
       developers: [%{id: 12, name: "Black Isle Studios"}],
       franchises: [],
       id: 14,
       name: "Fallout 2",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "co1mll",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mll.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mll.jpg"
       },
       publishers: [%{id: 5, name: "Interplay Entertainment"}],
       release_date: ~U[1998-09-30 00:00:00Z],
       short_description:
         "A turn-based tactical Western RPG in which the Chosen One is tasked with exploring post-nuclear California to locate and retrieve the fabled Garden of Eden Creation Kit for their famine-stricken tribe, while coming into contact through branching dialogue trees with numerous tribes, factions and micro-civilizations, each with their own virtues, vices, socioeconomic situations and political agendas."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {505,
     %{
       developers: [%{id: 25, name: "Ion Storm"}, %{id: 378, name: "Westlake Interactive"}],
       franchises: [],
       id: 41,
       name: "Deus Ex",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 8, name: "PlayStation 2"},
         %{id: 14, name: "Mac"},
         %{id: 45, name: "PlayStation Network"}
       ],
       poster: %{
         id: "co1r7n",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r7n.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r7n.jpg"
       },
       publishers: [
         %{id: 4, name: "Eidos Interactive"},
         %{id: 73, name: "Aspyr Media"},
         %{id: 26, name: "Square Enix"}
       ],
       release_date: ~U[2000-06-26 00:00:00Z],
       short_description:
         "In this philosophical first-person Western RPG set in a dystopian 2052, JC Denton, a nano-augmented agent for the anti-terrorist organization UNATCO, is tasked with stopping the invasion of Liberty Island by the terrorist group NSF. As events unfold, Denton finds that he plays a large part in a world-spanning conspiracy which forces him to ponder his allegiances, beliefs, morality, and view of right and wrong."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {157,
     %{
       developers: [%{id: 19, name: "Arkane Studios"}],
       franchises: [],
       id: 11118,
       name: "Dishonored 2",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "kbsmbhubsgur5enf1qpu",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/kbsmbhubsgur5enf1qpu.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/kbsmbhubsgur5enf1qpu.jpg"
       },
       publishers: [%{id: 28, name: "Bethesda Softworks LLC"}],
       release_date: ~U[2016-11-11 00:00:00Z],
       short_description:
         "Reprise your role as a supernatural assassin in Dishonored 2. Play your way in a world where mysticism and industry collide. Will you choose to play as Empress Emily Kaldwin or the Royal Protector, Corvo Attano? Will you stalk your way through the game unseen, make full use of its brutal combat system, or use a blend of both? How will you combine your character’s unique set of powers, weapons and gadgets to eliminate your enemies? The story responds to your choices, leading to intriguing outcomes, as you play through each of the game’s hand-crafted missions."
     }, %{id: 48, name: "PlayStation 4"}},
    {140,
     %{
       developers: [%{id: 47, name: "Obsidian Entertainment"}],
       franchises: [],
       id: 16,
       name: "Fallout: New Vegas",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "co1ora",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ora.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ora.jpg"
       },
       publishers: [
         %{id: 28, name: "Bethesda Softworks LLC"},
         %{id: 248, name: "Bandai Namco Entertainment"},
         %{id: 2493, name: "1C/Cenega"}
       ],
       release_date: ~U[2010-10-19 00:00:00Z],
       short_description:
         "In this first-person Western RPG, the player takes on the role of Courier 6, barely surviving after being robbed of their cargo, shot and put into a shallow grave by a New Vegas mob boss. The Courier sets out to track down their robbers and retrieve their cargo, and winds up getting tangled in the complex ideological and socioeconomic web of the many factions and settlements of post-nuclear Nevada."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {513,
     %{
       developers: [%{id: 51, name: "Blizzard Entertainment"}],
       franchises: [%{id: 135, name: "Warcraft"}],
       id: 132,
       name: "Warcraft III: Reign of Chaos",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "ad2vrrlzdsfy3s2fjtgv",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/ad2vrrlzdsfy3s2fjtgv.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/ad2vrrlzdsfy3s2fjtgv.jpg"
       },
       publishers: [
         %{id: 51, name: "Blizzard Entertainment"},
         %{id: 24, name: "Sierra Entertainment"},
         %{id: 37, name: "Capcom"}
       ],
       release_date: ~U[2002-07-03 00:00:00Z],
       short_description:
         "Warcraft 3: Reign of Chaos is an RTS made by Blizzard Entertainment. Take control of either the Humans, the Orcs, the Night Elves or the Undead, all with different unit types and heroes with unique abilities.Play the story driven single player campaign, go online to play default- or custom maps against people around the world or create your own maps with the map creation tool."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {150,
     %{
       developers: [%{id: 56, name: "Valve Corporation"}],
       franchises: [],
       id: 72,
       name: "Portal 2",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1qs2",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qs2.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qs2.jpg"
       },
       publishers: [%{id: 56, name: "Valve Corporation"}],
       release_date: ~U[2011-04-19 00:00:00Z],
       short_description:
         "Sequel to the acclaimed Portal (2007), Portal 2 pits the protagonist of the original game, Chell, and her new robot friend, Wheatley, against more puzzles conceived by GLaDOS, an A.I. with the sole purpose of testing the Portal Gun's mechanics and taking revenge on Chell for the events of Portal. As a result of several interactions and revelations, Chell once again pushes to escape Aperture Science Labs."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {521,
     %{
       developers: [%{id: 377, name: "Firaxis Games"}],
       franchises: [%{id: 10, name: "Sid Meier"}],
       id: 863,
       name: "Sid Meier's Alpha Centauri",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "qirb3fck2v5zs234tcgr",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/qirb3fck2v5zs234tcgr.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/qirb3fck2v5zs234tcgr.jpg"
       },
       publishers: [
         %{id: 1, name: "Electronic Arts"},
         %{id: 73, name: "Aspyr Media"},
         %{id: 106, name: "Loki Software"}
       ],
       release_date: ~U[1999-02-12 00:00:00Z],
       short_description:
         "Legendary designer Sid Meier presents the next evolution in strategy games, with the most addictive, compelling gameplay yet. Explore the alien planet that is your new home and uncover its myriad mysteries. Discover over 75 extraordinary technologies. Build over 60 base upgrades and large scales secret projects for your empire. Conquer your enemies with a war machine that you design from over 32,000 possible unit types."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {532,
     %{
       developers: [
         %{id: 224, name: "3D Realms"},
         %{id: 225, name: "Lobotomy Software"},
         %{id: 226, name: "Aardvark Software"},
         %{id: 2345, name: "Abstraction Games"}
       ],
       franchises: [],
       id: 342,
       name: "Duke Nukem 3D",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"},
         %{id: 29, name: "Sega Mega Drive/Genesis"},
         %{id: 32, name: "Sega Saturn"},
         %{id: 39, name: "iOS"},
         %{id: 46, name: "PlayStation Vita"},
         %{id: 48, name: "PlayStation 4"}
       ],
       poster: %{
         id: "nctdw391mcn9v5cyn9o2",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/nctdw391mcn9v5cyn9o2.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/nctdw391mcn9v5cyn9o2.jpg"
       },
       publishers: [
         %{id: 224, name: "3D Realms"},
         %{id: 205, name: "GT Interactive"},
         %{id: 227, name: "U.S. Gold"},
         %{id: 228, name: "FormGen"},
         %{id: 229, name: "SEGA of America"},
         %{id: 230, name: "MachineWorks Northwest"},
         %{id: 231, name: "Tec Toy Indústria de Brinquedos"},
         %{id: 130, name: "MacSoft Games"},
         %{id: 634, name: "Devolver Digital"}
       ],
       release_date: ~U[1996-01-29 00:00:00Z],
       short_description:
         "Aliens have landed in futuristic Los Angeles and it's up to the Duke to bring the pain and show them the door. After the initial entries of side-scrolling platform games, Duke Nukem 3D introduces a first-person perspective to the series and turns the game into a full-fledged shooter with 2.5D graphics. \n \nDuke's arsenal includes pistols, pipe bombs, laser trip mines, Nordenfelt guns, a chain gun and various rocket launchers, but also his mighty foot to kick enemies. The game sports a high level of interactivity. Many objects in the environment can be broken or interacted with, such as pool tables, arcade machines, glass, light switches and security cameras. The protagonist is also able to hand strippers a dollars to have them remove their top."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {535,
     %{
       developers: [%{id: 51, name: "Blizzard Entertainment"}],
       franchises: [%{id: 135, name: "Warcraft"}],
       id: 130,
       name: "Warcraft II: Tides of Darkness",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"},
         %{id: 32, name: "Sega Saturn"}
       ],
       poster: %{
         id: "olpk2nfqu4susanmykqu",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/olpk2nfqu4susanmykqu.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/olpk2nfqu4susanmykqu.jpg"
       },
       publishers: [
         %{id: 51, name: "Blizzard Entertainment"},
         %{id: 1, name: "Electronic Arts"},
         %{id: 200, name: "Electronic Arts Victor"}
       ],
       release_date: ~U[1995-12-09 00:00:00Z],
       short_description:
         "Warcraft 2 is a successor of the popular Warcraft real-time strategy game. The game contains many improvements over the previous version in graphics, sounds and playability. The Multiplayer was also greatly improved allowing up to 8 players in the marvelous multiplayer skirmish."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {420,
     %{
       developers: [
         %{id: 2675, name: "Nex Entertainment"},
         %{id: 3775, name: "Bee Tribe"},
         %{id: 852, name: "Platinum Games"}
       ],
       franchises: [],
       id: 2136,
       name: "Bayonetta",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 41, name: "Wii U"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1p92",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1p92.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1p92.jpg"
       },
       publishers: [%{id: 112, name: "Sega"}, %{id: 70, name: "Nintendo"}],
       release_date: ~U[2009-10-29 00:00:00Z],
       short_description:
         "A member of an ancient witch clan and possessing powers beyond the comprehension of mere mortals, Bayonetta faces-off against countless angelic enemies, many reaching epic proportions, in a game of 100% pure, unadulterated all-out action. Outlandish finishing moves are performed with balletic grace as Bayonetta flows from one fight to another. With magnificent over-the-top action taking place in stages that are a veritable theme park of exciting attractions, Bayonetta pushes the limits of the action genre, bringing to life its fast-paced, dynamic climax combat."
     }, %{id: 130, name: "Nintendo Switch"}},
    {439,
     %{
       developers: [%{id: 47, name: "Obsidian Entertainment"}],
       franchises: [%{id: 28, name: "South Park"}],
       id: 1262,
       name: "South Park: The Stick of Truth",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 36, name: "Xbox Live Arcade"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "mlbqx1gygvgntwaecz6p",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/mlbqx1gygvgntwaecz6p.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/mlbqx1gygvgntwaecz6p.jpg"
       },
       publishers: [%{id: 104, name: "Ubisoft Entertainment"}],
       release_date: ~U[2014-03-04 00:00:00Z],
       short_description:
         "From the perilous battlefields of the fourth-grade playground, a young hero will rise, destined to be South Park’s savior. From the creators of South Park, Trey Parker and Matt Stone, comes an epic quest to become… cool. Introducing South Park™: The Stick of Truth™.You begin as the new kid in town facing a harrowing challenge: making friends. \n \nAs you start your quest the children of South Park are embroiled in a city-wide, live-action-role-playing game, casting imaginary spells and swinging fake swords. Over time the simple children’s game escalates into a battle of good and evil that threatens to consume the world.Arm yourself with weapons of legend to defeat crab people, underpants gnomes, hippies and other forces of evil. \n \nDiscover the lost Stick of Truth and earn your place at the side of Stan, Kyle, Cartman and Kenny as their new friend. Succeed, and you shall be South Park’s savior, cementing your social status in South Park Elementary. Fail, and you will forever be known… as a loser."
     }, %{id: 130, name: "Nintendo Switch"}},
    {508,
     %{
       developers: [%{id: 59, name: "Blizzard North"}],
       franchises: [],
       id: 126,
       name: "Diablo II",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "rdxf2fdxiutxiw0dumto",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/rdxf2fdxiutxiw0dumto.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/rdxf2fdxiutxiw0dumto.jpg"
       },
       publishers: [
         %{id: 51, name: "Blizzard Entertainment"},
         %{id: 24, name: "Sierra Entertainment"},
         %{id: 4090, name: "Havas Interactive"}
       ],
       release_date: ~U[2000-06-29 00:00:00Z],
       short_description:
         "A top down adventure game of epic proportion. Diablo 2 is the continuation of a wonderful world of magic and horror. - - \"There is no escape from chaos, there is only the sweet release of death\""
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {548,
     %{
       developers: [%{id: 646, name: "Blue Byte Software"}],
       franchises: [],
       id: 3696,
       name: "The Settlers III",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "esjezaahlo1wzqdd78mg",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/esjezaahlo1wzqdd78mg.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/esjezaahlo1wzqdd78mg.jpg"
       },
       publishers: [%{id: 646, name: "Blue Byte Software"}],
       release_date: ~U[1998-11-30 00:00:00Z],
       short_description:
         "The gods may be crazy! First the Almighty HE, the highest of all the gods, sends Jupiter, Horus, and Ch’ib-Yu off into an extremely arduous competition simply on account of some occasional drinking sprees! Then the three gods are subjected to scorn and derision: Q'nqura, the goddess of the Amazons, lets the trio win in battle out of pure spite, and then their humiliation is complete!"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {544,
     %{
       developers: [%{id: 113, name: "Westwood Studios"}, %{id: 3, name: "Looking Glass Studios"}],
       franchises: [%{id: 12, name: "Command & Conquer"}],
       id: 647,
       name: "Command & Conquer",
       platforms: [
         %{id: 4, name: "Nintendo 64"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"},
         %{id: 32, name: "Sega Saturn"}
       ],
       poster: %{
         id: "co1p41",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1p41.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1p41.jpg"
       },
       publishers: [
         %{id: 141, name: "Virgin Interactive Entertainment (Europe) Ltd."},
         %{id: 112, name: "Sega"},
         %{id: 70, name: "Nintendo"}
       ],
       release_date: ~U[1995-08-31 00:00:00Z],
       short_description:
         "Experience the game that started it all! Enter a gritty, high-tech world and take advantage of electronic intelligence and covert surveillance to determine who reigns supreme. Join either the forces of the Global Defense Initiative (GDI) or the Brotherhood of Nod as you build bases, muster forces and dominate your enemies. All for the love of power. Play as the Brotherhood and obey the charismatic Kane’s every command or take control of GDI forces as they seek to save the world from Kane’s ambition. Gather Tiberium to produce tanks, infantry and more to decide the fate of the world."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {528,
     %{
       developers: [%{id: 68, name: "Ensemble Studios"}],
       franchises: [],
       id: 289,
       name: "Age of Empires",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "lclbmfihd2crlasugy6b",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/lclbmfihd2crlasugy6b.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/lclbmfihd2crlasugy6b.jpg"
       },
       publishers: [%{id: 128, name: "Microsoft"}, %{id: 130, name: "MacSoft Games"}],
       release_date: ~U[1997-10-15 00:00:00Z],
       short_description:
         "Age of Empires (AoE) is a history-based real-time strategy video game developed by Ensemble Studios and published by Microsoft. The game uses the Genie, a 2D sprite-based game engine. The game allows the user to act as the leader of an ancient civilization by advancing it through four ages (the Stone, Tool, Bronze, and Iron Ages), gaining access to new and improved units with each advance."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {167,
     %{
       developers: [%{id: 834, name: "Insomniac Games"}],
       franchises: [],
       id: 11065,
       name: "Ratchet & Clank",
       platforms: [%{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1ifs",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ifs.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ifs.jpg"
       },
       publishers: [%{id: 45, name: "Sony Computer Entertainment, Inc. (SCEI)"}],
       release_date: ~U[2016-04-12 00:00:00Z],
       short_description:
         "Ratchet & Clank is a new game based on elements from the original Ratchet & Clank (PS2), featuring more than an hour of new cinematics (including footage from the film) in vibrant 1080p, new locations, weapons, bosses and more. Join Ratchet, Clank, Captain Qwark and new friends as they embark on an intergalactic adventure, and experience the start of an epic friendship (again) on PlayStation 4."
     }, %{id: 48, name: "PlayStation 4"}},
    {468,
     %{
       developers: [%{id: 129, name: "Konami"}, %{id: 129, name: "Konami"}],
       franchises: [],
       id: 4598,
       name: "Contra",
       platforms: [
         %{id: 8, name: "PlayStation 2"},
         %{id: 13, name: "PC DOS"},
         %{id: 15, name: "Commodore C64/128"},
         %{id: 18, name: "Nintendo Entertainment System (NES)"},
         %{id: 25, name: "Amstrad CPC"},
         %{id: 26, name: "ZX Spectrum"},
         %{id: 36, name: "Xbox Live Arcade"},
         %{id: 47, name: "Virtual Console (Nintendo)"},
         %{id: 51, name: "Family Computer Disk System"},
         %{id: 52, name: "Arcade"},
         %{id: 53, name: "MSX2"}
       ],
       poster: %{
         id: "co1qnw",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qnw.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qnw.jpg"
       },
       publishers: [%{id: 129, name: "Konami"}, %{id: 1271, name: "Ocean Software"}],
       release_date: ~U[1987-02-20 00:00:00Z],
       short_description:
         "Contra (魂斗羅 Kontora), known as Probotector in Europe and Gryzor in Oceania, is a 1987 run and gun action game developed and published by Konami originally released as a coin-operated arcade game on February 20, 1987. A home version was released for the Nintendo Entertainment System in 1988, along with ports for various computer formats, including the MSX2. The home versions were localized in the PAL region as Gryzor on the various computer formats and as Probotector on the NES, released later. Several Contra sequels were produced following the original game."
     }, %{id: 18, name: "Nintendo Entertainment System (NES)"}},
    {551,
     %{
       developers: [%{id: 152, name: "MicroProse"}],
       franchises: [%{id: 10, name: "Sid Meier"}],
       id: 634,
       name: "Sid Meier's Civilization II",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "v4kakyrrncafsrhabd76",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/v4kakyrrncafsrhabd76.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/v4kakyrrncafsrhabd76.jpg"
       },
       publishers: [%{id: 152, name: "MicroProse"}],
       release_date: ~U[1996-02-29 00:00:00Z],
       short_description:
         "A turn-based strategy video game set around several different historic civilizations."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {449,
     %{
       developers: [%{id: 876, name: "Sora"}, %{id: 8134, name: "BANDAI NAMCO Studios Inc."}],
       franchises: [
         %{id: 24, name: "Mario Bros."},
         %{id: 596, name: "The Legend of Zelda"},
         %{id: 756, name: "Metroid"},
         %{id: 789, name: "Kirby"},
         %{id: 1228, name: "Splatoon"}
       ],
       id: 90101,
       name: "Super Smash Bros. Ultimate",
       platforms: [%{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "co1r8b",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r8b.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r8b.jpg"
       },
       publishers: [%{id: 70, name: "Nintendo"}],
       release_date: ~U[2018-12-07 00:00:00Z],
       short_description:
         "Legendary game worlds and fighters collide in the ultimate showdown—a new entry in the Super Smash Bros. series for the Nintendo Switch system! New fighters, like Inkling from the Splatoon series and Ridley from the Metroid series, make their Super Smash Bros. series debut alongside every Super Smash Bros. fighter in the series…EVER! Faster combat, new items, new attacks, new defensive options, and more will keep the battle raging whether you’re at home or on the go."
     }, %{id: 130, name: "Nintendo Switch"}},
    {509,
     %{
       developers: [%{id: 100, name: "Nival Interactive"}],
       franchises: [],
       id: 11407,
       name: "Etherlords",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "pkzaxehlnfe4c4epf1id",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/pkzaxehlnfe4c4epf1id.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/pkzaxehlnfe4c4epf1id.jpg"
       },
       publishers: [%{id: 11800, name: "Fishtank Interactive"}],
       release_date: ~U[2014-02-13 00:00:00Z],
       short_description:
         "Etherlords is an exciting mix of turn-based strategy and fantasy trading card game. Innovative game mechanics that first appeared in this game formed the basics of most modern games of this genre. \n \nEnter the world of Etherlords as a champion of one of the four great magical races: the powerful Chaots, the brilliant Kinets, the empathetic Vitals, or the ruthless biomechanical Synthets. Create a powerful deck of cards to summon troops who will follow your every command: exploring the world, conquering territories, battling the minions of enemy lords and ferocious creatures unleashed by the disturbances in the flow of the Ether. Build forces, create spells, and engage in diplomacy. Collect essential resources to fuel your armies, upgrade and enhance your spell sets, and create powerful spell books for conducting duels in the best traditions of trading card gameplay."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {514,
     %{
       developers: [%{id: 5, name: "Interplay Entertainment"}],
       franchises: [],
       id: 775,
       name: "M.A.X.: Mechanized Assault & Exploration",
       platforms: [%{id: 13, name: "PC DOS"}],
       poster: %{
         id: "p6fe8flyyaswuiqrowtq",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/p6fe8flyyaswuiqrowtq.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/p6fe8flyyaswuiqrowtq.jpg"
       },
       publishers: [%{id: 5, name: "Interplay Entertainment"}],
       release_date: ~U[1996-12-31 00:00:00Z],
       short_description:
         "Your Mission: colonize new worlds on distant planets. As the Mission Commander, you and the Mechanized Assault & Exploration (M.A.X.) Force you lead are the first ones in. Mining stations, power plants, tactical combat vehicle factories, habitats - it's up to you to plan and construct them. The entire new colony? You create it. The resources you find there? Control them. Enemies? Crush 'em! And there will be enemies. You're not the only Mission Commander trying to colonize the planets. You'll have to push yourself to the limit to survive the ultimate showdown in strategic warfare. It's espionage, heavy artillery, offensives, counter offensives and intelligence - all with maximum consequences! Features: For ultimate customization control, play as one of eight factions, choose from over 50 land, sea, and air units, upgrade armor, speed, and range. Campaign and custom missions. Simultaneous or turn based game play plus adjustable turn length and game speed will challenge both real-time and turn-based strategy gamers. Any combination of up to four human or computer opponents can wage war."
     }, %{id: 13, name: "PC DOS"}},
    {520,
     %{
       developers: [%{id: 12, name: "Black Isle Studios"}],
       franchises: [],
       id: 13,
       name: "Fallout",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1nx9",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nx9.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nx9.jpg"
       },
       publishers: [%{id: 244, name: "Edusoft"}, %{id: 5, name: "Interplay Entertainment"}],
       release_date: ~U[1997-09-30 00:00:00Z],
       short_description:
         "The Vault Dweller is tasked with exploring post-nuclear California in order to retrieve a water chip to replace the broken chip of Vault 13, their home, which they are the first person to ever leave. The player will engage in Western RPG character building and turn-based tactical combat while getting to know settlements and factions of people, mutants and ghouls through branching dialogue trees."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {600,
     %{
       developers: [%{id: 510, name: "Larian Studios"}],
       franchises: [],
       id: 103_337,
       name: "Divinity: Original Sin II - Definitive Edition",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "kfvhueojjdulqgc1qavs",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/kfvhueojjdulqgc1qavs.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/kfvhueojjdulqgc1qavs.jpg"
       },
       publishers: [%{id: 248, name: "Bandai Namco Entertainment"}],
       release_date: ~U[2018-08-31 00:00:00Z],
       short_description:
         "There can only be one God. The Divine is dead. The Void approaches. And the powers lying dormant within you are soon to awaken. The battle for Divinity has begun. Choose wisely and trust sparingly; darkness lurks within every heart. Master deep, tactical combat. Join up to 3 other players - but know that only one of you will have the chance to become a God, in multi-award winning RPG Divinity: Original Sin 2."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {510,
     %{
       developers: [%{id: 144, name: "GSC Game World"}],
       franchises: [],
       id: 242,
       name: "Cossacks: European Wars",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "tmq7ozgae1mmhoswrcz7",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/tmq7ozgae1mmhoswrcz7.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/tmq7ozgae1mmhoswrcz7.jpg"
       },
       publishers: [
         %{id: 146, name: "Strategy First"},
         %{id: 145, name: "cdv Software Entertainment"},
         %{id: 144, name: "GSC Game World"}
       ],
       release_date: ~U[2001-03-30 00:00:00Z],
       short_description:
         "Cossacks: European Wars is a real-time strategy computer game for Windows made by the Ukrainian developer GSC Game World. It was released on April 24, 2001. The game has an isometric view and is set in the 17th and 18th centuries of Europe. It features sixteen playable nations each with its own architectural styles, technologies and units. \nPlayers must avoid famine and engage in army expansion, building construction and simple resource gathering. Mission scenarios range from conflicts such as Thirty Years' War to the War of the Austrian Succession, and the game is renowned for the seemingly unlimited number of units players may control. This ability set it apart from other games of the time such as Age of Empires and Empire Earth. \nCossacks is a game which allows the user to gain strategy skills and even pick up some relative history of that period by the inclusion of a comprehensive encyclopedia. This top selling title has won two awards and was positively favoured by a majority of reviewers."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {183,
     %{
       developers: [%{id: 7466, name: "Paradox Development Studio"}],
       franchises: [],
       id: 11582,
       name: "Stellaris",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "co1r75",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r75.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r75.jpg"
       },
       publishers: [%{id: 517, name: "Paradox Interactive"}],
       release_date: ~U[2016-05-09 00:00:00Z],
       short_description:
         "Explore a vast galaxy full of wonder! Paradox Development Studio, makers of the Crusader Kings and Europa Universalis series presents Stellaris, an evolution of the grand strategy genre with space exploration at its core. \n \nFeaturing deep strategic gameplay, an enormous selection of alien races and emergent storytelling, Stellaris has a deeply challenging system that rewards interstellar exploration as you traverse, discover, interact and learn more about the multitude of species you will encounter during your travels. \n \nEtch your name across the cosmos by uncovering remote celestial outposts,and entire civilizations. Will you expand through war or walk the path of diplomacy to achieve your goals?"
     }, %{id: 14, name: "Mac"}},
    {478,
     %{
       developers: [%{id: 326, name: "Cyan Worlds"}],
       franchises: [],
       id: 236,
       name: "Myst",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 14, name: "Mac"},
         %{id: 20, name: "Nintendo DS"},
         %{id: 32, name: "Sega Saturn"},
         %{id: 38, name: "PlayStation Portable"},
         %{id: 39, name: "iOS"}
       ],
       poster: %{
         id: "g5smh1yjndwdw6ibxado",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/g5smh1yjndwdw6ibxado.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/g5smh1yjndwdw6ibxado.jpg"
       },
       publishers: [
         %{id: 195, name: "Brøderbund Software"},
         %{id: 327, name: "Midway Games"},
         %{id: 328, name: "Mean Hamster Software"},
         %{id: 251, name: "Sunsoft"}
       ],
       release_date: ~U[1993-09-24 00:00:00Z],
       short_description:
         "A mystical journey through worlds that changed the concept of an adventure game."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {181,
     %{
       developers: [%{id: 377, name: "Firaxis Games"}],
       franchises: [%{id: 10, name: "Sid Meier"}],
       id: 19130,
       name: "Sid Meier's Civilization VI",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 39, name: "iOS"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "zhqjcjfltpubefktcghk",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/zhqjcjfltpubefktcghk.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/zhqjcjfltpubefktcghk.jpg"
       },
       publishers: [%{id: 8, name: "2K Games"}, %{id: 73, name: "Aspyr Media"}],
       release_date: ~U[2016-10-21 00:00:00Z],
       short_description:
         "Civilization is a turn-based strategy game in which you attempt to build an empire to stand the test of time. Become Ruler of the World by establishing and leading a civilization from the Stone Age to the Information Age. Wage war, conduct diplomacy, advance your culture, and go head-to-head with history’s greatest leaders as you attempt to build the greatest civilization the world has ever known.\n\nCivilization VI offers new ways to engage with your world: cities now physically expand across the map, active research in technology and culture unlocks new potential, and competing leaders will pursue their own agendas based on their historical traits as you race for one of five ways to achieve victory in the game."
     }, %{id: 14, name: "Mac"}},
    {536,
     %{
       developers: [%{id: 369, name: "Chris Sawyer"}],
       franchises: [],
       id: 5504,
       name: "Transport Tycoon",
       platforms: [%{id: 13, name: "PC DOS"}],
       poster: %{
         id: "l0amwldd5rsozeae0i8b",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/l0amwldd5rsozeae0i8b.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/l0amwldd5rsozeae0i8b.jpg"
       },
       publishers: [%{id: 152, name: "MicroProse"}],
       release_date: ~U[1994-12-31 00:00:00Z],
       short_description:
         "Released on PC in 1994. Developed by Chris Sawyer, and coded in X86 Assembly language, it was among the first in the relatively new 'tycoon' genre of games - simulations of business empires that the player founded, grew and took full control of.\n\nTransport Tycoon saw the player running their transport empire from 1930 to 2030, with rail, road, sea and air transport available to help the player's expansion of their business. New technologies are introduced to the player at historically accurate times, and players could see first-hand how advancements changed the way their businesses were run."
     }, %{id: 13, name: "PC DOS"}},
    {545,
     %{
       developers: [%{id: 113, name: "Westwood Studios"}],
       franchises: [%{id: 12, name: "Command & Conquer"}],
       id: 295,
       name: "Command & Conquer: Red Alert",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 13, name: "PC DOS"},
         %{id: 38, name: "PlayStation Portable"}
       ],
       poster: %{
         id: "co1nx0",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nx0.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nx0.jpg"
       },
       publishers: [
         %{id: 17160, name: "Virgin Interactive Entertainment"},
         %{id: 13634, name: "Sony Computer Entertainment"},
         %{id: 1, name: "Electronic Arts"}
       ],
       release_date: ~U[1996-10-31 00:00:00Z],
       short_description:
         "Travel to an alternate universe where dark experiments have permanently altered time. Or have they? Soviet tanks crush city after city while Allied cruisers shell bases. Spies lurk, landmines await, and strange new technologies aid both sides in the struggle for ultimate control. In this parallel reality, the mighty Soviet Empire has begun to “liberate” all of Europe. Cities fall and countries collapse before the overwhelming might of the Red Storm. The Allies are scrambling to meet the onslaught, but they have been caught by surprise. Red Alert puts the fate of the world in your hands!"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {594,
     %{
       developers: [%{id: 377, name: "Firaxis Games"}],
       franchises: [],
       id: 10919,
       name: "XCOM 2",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1mvj",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mvj.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mvj.jpg"
       },
       publishers: [%{id: 8, name: "2K Games"}, %{id: 23, name: "Feral Interactive"}],
       release_date: ~U[2016-02-05 00:00:00Z],
       short_description:
         "In XCOM 2, the roles have been reversed, and XCOM is now the invading force. They are hampered by limited resources and must constantly evade the alien threat in their new mobile headquarters. Players must use a combination of firepower and stealth-like tactics to help XCOM recruit soldiers and build a resistance network, while attempting to expose the evil alien agenda and save humanity. \n\nXCOM 2 will introduce gameplay features such as procedurally-generated levels, which will make each experience unique to the player, as well as offer a much deeper level of modding support. Additionally, XCOM 2 will offer a variety of new content including five updated soldier classes, increased soldier customization, more alien and enemy types, evolved tactical combat and more."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {567,
     %{
       developers: [%{id: 37, name: "Capcom"}],
       franchises: [],
       id: 76253,
       name: "Devil May Cry 5",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "a2ppkmdjno7ja5w24qeq",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/a2ppkmdjno7ja5w24qeq.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/a2ppkmdjno7ja5w24qeq.jpg"
       },
       publishers: [%{id: 37, name: "Capcom"}],
       release_date: ~U[2019-03-08 00:00:00Z],
       short_description:
         "A brand new entry in the legendary over-the-top action series comes to Xbox One, PlayStation 4, and PC in Spring 2019, complete with its signature blend of high-octane stylized action and otherworldly and original characters the series is known for. Director Hideaki Itsuno and the core team have reunited to create the most over the top, technically advanced, utterly insane action experience of this generation. \n \nYears have passed since the legions of hell have set foot in this world, but now a new demonic invasion has begun, and humanity’s last hope will rest in the hands of three lone demon hunters, each offering a radically different play style. United by fate and a thirst for vengeance, these demon hunters will have to face their demons if they hope to survive."
     }, %{id: 48, name: "PlayStation 4"}},
    {533,
     %{
       developers: [],
       franchises: [],
       id: 4268,
       name: "Panzer General",
       platforms: [%{id: 13, name: "PC DOS"}, %{id: 50, name: "3DO Interactive Multiplayer"}],
       poster: %{
         id: "rdafnqtmrpfljjeo0ohx",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/rdafnqtmrpfljjeo0ohx.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/rdafnqtmrpfljjeo0ohx.jpg"
       },
       publishers: [],
       release_date: ~U[1994-12-01 00:00:00Z],
       short_description:
         "You are the brightest and best of the new Axis generals in the Second World War. Your tactical skills will be tested in armored assaults, amphibious invasions, paradrops, naval engagements, and fierce aerial combat for control of the skies. Go from triumph to triumph, invading and seizing the capitals of Great Britain, the Soviet Union, and ultimately the United States of America on your way to conquering the whole world! Can you achieve a place in history?"
     }, %{id: 13, name: "PC DOS"}},
    {527,
     %{
       developers: [%{id: 604, name: "Cavedog Entertainment"}],
       franchises: [],
       id: 918,
       name: "Total Annihilation",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "co1pcw",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1pcw.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1pcw.jpg"
       },
       publishers: [%{id: 205, name: "GT Interactive"}],
       release_date: ~U[1997-09-30 00:00:00Z],
       short_description:
         "What began as a conflict over the transfer of consciousness from flesh to machines escalated into a war which has decimated a million worlds. The Core and the Arm have all but exhausted the resources of a galaxy in their struggle for domination. Both sides now crippled beyond repair, the remnants of their armies continue to battle on ravaged planets, their hatred fuelled by over four thousand years of total war. This is a fight to the death. For each side, the only acceptable outcome is the complete elimination of the other."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {391,
     %{
       developers: [%{id: 943, name: "Colossal Order"}],
       franchises: [],
       id: 9066,
       name: "Cities: Skylines",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "co1mx3",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mx3.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mx3.jpg"
       },
       publishers: [%{id: 517, name: "Paradox Interactive"}],
       release_date: ~U[2015-03-10 00:00:00Z],
       short_description:
         "Cities: Skylines is a modern take on the classic city simulation. The game introduces new game play elements to realize the thrill and hardships of creating and maintaining a real city whilst expanding on some well-established tropes of the city building experience. From the makers of the Cities in Motion franchise, the game boasts a fully realized transport system. It also includes the ability to mod the game to suit your play style as a fine counter balance to the layered and challenging simulation. You’re only limited by your imagination, so take control and reach for the sky!"
     }, %{id: 14, name: "Mac"}},
    {471,
     %{
       developers: [%{id: 722, name: "343 Industries"}],
       franchises: [%{id: 137, name: "Halo"}],
       id: 991,
       name: "Halo 4",
       platforms: [%{id: 12, name: "Xbox 360"}, %{id: 49, name: "Xbox One"}],
       poster: %{
         id: "co1huj",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1huj.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1huj.jpg"
       },
       publishers: [%{id: 1010, name: "Microsoft Studios"}],
       release_date: ~U[2012-11-06 00:00:00Z],
       short_description:
         "Halo 4 marks the start of an epic new saga within the award-winning Halo universe. The Master Chief returns in this award-winning first-person shooter developed by 343 Industries. Shipwrecked on a mysterious world, faced with new enemies and deadly technology, the Chief returns to battle against an ancient evil bent on vengeance and annihilation...the universe will never be the same."
     }, %{id: 12, name: "Xbox 360"}},
    {547,
     %{
       developers: [%{id: 113, name: "Westwood Studios"}],
       franchises: [%{id: 52, name: "Fables and Fiends"}],
       id: 1282,
       name: "The Legend of Kyrandia",
       platforms: [%{id: 13, name: "PC DOS"}, %{id: 14, name: "Mac"}, %{id: 16, name: "Amiga"}],
       poster: %{
         id: "ehgnsbxzuohvjktm8vje",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/ehgnsbxzuohvjktm8vje.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/ehgnsbxzuohvjktm8vje.jpg"
       },
       publishers: [%{id: 113, name: "Westwood Studios"}],
       release_date: ~U[1992-01-01 00:00:00Z],
       short_description:
         "Kyrandia is a land of dark, mysterious forests, and sleeping dragons. A fantastic land where rubies grow on trees and magic abounds. Who would imagine that a land so idyllic would spawn a murderer so demented? Some say that the court jester, Malcolm, was mad to begin with. Others whisper in sly, conspiratorial tones\nthat it was his burning desire to possess the precious Kyragem that slowly drove him to slay the peaceful King William.\n\nAs the rightful prince of Kyrandia, you must pursue the elusive Malcolm to recover the powerful gemstone. Only then will you be able to reclaim the throne and restore harmony to the land of Kyrandia. The Legend of Kyrandia awaits you!"
     }, %{id: 13, name: "PC DOS"}},
    {448,
     %{
       developers: [%{id: 818, name: "Atlus"}, %{id: 9969, name: "P Studio"}],
       franchises: [%{id: 592, name: "Megami Tensei"}],
       id: 9927,
       name: "Persona 5",
       platforms: [%{id: 9, name: "PlayStation 3"}, %{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1r76",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r76.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r76.jpg"
       },
       publishers: [
         %{id: 818, name: "Atlus"},
         %{id: 2488, name: "Atlus USA"},
         %{id: 423, name: "Deep Silver"}
       ],
       release_date: ~U[2016-09-15 00:00:00Z],
       short_description:
         "Persona 5, a turn-based JRPG with visual novel elements, follows a high school student with a criminal record for a crime he didn't commit. Soon he meets several characters who share similar fates to him, and discovers a metaphysical realm which allows him and his friends to channel their pent-up frustrations into becoming a group of vigilantes reveling in aesthetics and rebellion while fighting corruption."
     }, %{id: 48, name: "PlayStation 4"}},
    {148,
     %{
       developers: [%{id: 26, name: "Square Enix"}],
       franchises: [%{id: 4, name: "Final Fantasy"}],
       id: 425,
       name: "Final Fantasy VIII",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 45, name: "PlayStation Network"}
       ],
       poster: %{
         id: "co1l93",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1l93.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1l93.jpg"
       },
       publishers: [
         %{id: 4, name: "Eidos Interactive"},
         %{id: 252, name: "Square Electronic Arts"},
         %{id: 26, name: "Square Enix"},
         %{id: 4107, name: "SCE Australia"},
         %{id: 324, name: "Square Soft"}
       ],
       release_date: ~U[1999-02-11 00:00:00Z],
       short_description:
         "It is a time of war. Galbadia, a Global Superpower, has declared war on Dollet, a country whose training academy is home to two personalities: the hot-headed Seifer and the 'lone wolf', Squall Leonhart. Both are equally at conflict with each other as their country is with Galbadia; to others, Squall appears lacking in team spirit, while Seifer lacks the discipline of his rival. However, a chance encounter with the free-spirited Rinoa Heartilly turns Squall's universe upside down; having thrived on discipline, Squall find the carefree Rinoa fascinating. He also begins to dream that he is Laguna Loire, a Galbadian army soldier."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {367,
     %{
       developers: [%{id: 537, name: "Massive Entertainment"}],
       franchises: [],
       id: 941,
       name: "World in Conflict",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "k9uipm7mhavjguy81weh",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/k9uipm7mhavjguy81weh.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/k9uipm7mhavjguy81weh.jpg"
       },
       publishers: [%{id: 24, name: "Sierra Entertainment"}],
       release_date: ~U[2007-09-18 00:00:00Z],
       short_description:
         "World War III rages and a Soviet-led army has launched a surprise attack on the U.S.A. Command your troops into fast-paced battles fought on a fully destructible battle-field. Strategy meets intense action in this epic clash of Super Powers!"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {415,
     %{
       developers: [%{id: 26, name: "Square Enix"}],
       franchises: [],
       id: 26765,
       name: "Octopath Traveler",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "co1mpu",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mpu.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mpu.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}, %{id: 70, name: "Nintendo"}],
       release_date: ~U[2018-07-13 00:00:00Z],
       short_description:
         "A role-playing game from the Bravely Default team is being developed exclusively for the Nintendo Switch. They have brought a new world to life through a mix of CG, pixel art, and \"HD-2D\" visuals."
     }, %{id: 130, name: "Nintendo Switch"}},
    {523,
     %{
       developers: [],
       franchises: [],
       id: 13628,
       name: "Echelon",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "btqkiehzo3hffrxv39ph",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/btqkiehzo3hffrxv39ph.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/btqkiehzo3hffrxv39ph.jpg"
       },
       publishers: [%{id: 2992, name: "Buka Entertainment"}],
       release_date: ~U[2001-04-15 00:00:00Z],
       short_description:
         "It's the year 2351, and you're a pilot trying to rise through the ranks all the way to glory. As a member of the Galactic Federation, you'll be granted more than 20 weapons to use in each pass-fail mission. Your goal is to defend the planet from attacking alien forces, and you'll put your skills into play across more than 30 campaigns. There's a huge list of aircraft for you to tame ranging from helicopters and planes to high-tech hovercraft. With 100 vehicles in all, deadly enemies, and 3D graphics, ECHELON is one far out trip through the solar system."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {541,
     %{
       developers: [%{id: 938, name: "Coktel Vision"}],
       franchises: [],
       id: 1931,
       name: "Gobliins 2: The Prince Buffoon",
       platforms: [
         %{id: 13, name: "PC DOS"},
         %{id: 16, name: "Amiga"},
         %{id: 63, name: "Atari ST/STE"}
       ],
       poster: %{
         id: "xt9vjhcwxlbnj9eqvopn",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/xt9vjhcwxlbnj9eqvopn.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/xt9vjhcwxlbnj9eqvopn.jpg"
       },
       publishers: [%{id: 32, name: "Sierra On-Line"}],
       release_date: ~U[1992-12-31 00:00:00Z],
       short_description:
         "The second in the series of adventure-puzzle games. In this installation, you only have two imps to control instead of three. \n \nSomeone has kidnapped the prince and it's up to you and two hilarious sidekicks, Winkle and Fingus, to rescue him. Winkle is a reckless jokester, while Fingus is careful and has a gift for solving puzzles. Luckily, they're blessed with extraordinary vitality. In other words, they never die. That'll sure come in handy when you're up against Wily Wizard's traps, maniacal monsters, and twisted and perplexing puzzles."
     }, %{id: 13, name: "PC DOS"}},
    {482,
     %{
       developers: [%{id: 438, name: "Infinity Ward"}],
       franchises: [%{id: 726, name: "Call of Duty"}],
       id: 621,
       name: "Call of Duty",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1o5c",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1o5c.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1o5c.jpg"
       },
       publishers: [%{id: 66, name: "Activision"}],
       release_date: ~U[2003-10-29 00:00:00Z],
       short_description:
         "The player has two primary weapon slots, a handgun slot and can carry up to eight grenades (all of the later Call of Duty games feature only two weapon slots; a sidearm will fill one of these slots). Weapons may be exchanged with those found on the battlefield dropped by dead soldiers."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {549,
     %{
       developers: [%{id: 152, name: "MicroProse"}],
       franchises: [],
       id: 25,
       name: "X-COM: Terror From The Deep",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 13, name: "PC DOS"}
       ],
       poster: %{
         id: "dwvgbfj94czij1ycefh9",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/dwvgbfj94czij1ycefh9.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/dwvgbfj94czij1ycefh9.jpg"
       },
       publishers: [
         %{id: 152, name: "MicroProse"},
         %{id: 183, name: "Hasbro Interactive"},
         %{id: 8, name: "2K Games"}
       ],
       release_date: ~U[1995-01-01 00:00:00Z],
       short_description:
         "A vast sleeping enemy has awakened. When the colonization vessel crash landed on Earth some 65 million years ago, the emergency systems placed the aliens in suspended animation. A distress call was sent, but was never received by the aliens’ homeworld. Over the eons the computers awakened small groups of aliens to attempt colonization, but the strategies and devices were imperfect. The aliens have also sunken ships, destroyed planes and devastated remote ports over the centuries — to what end we know not. \n \nNow, deep in the vast hulk of the mother ship the battle computers have become fully online. The systematic awakening of the aliens and their technology has begun. Across the globe are sites where age-old alien advance assault squads have been attempting to contact their distant brothers. The sites contain powerful artifacts that they need to conquer the planet and transform it into an aquatic paradise for aliens. \nX-COM: Terror From The Deep puts you in command of X-COM. You control the force to stop the alien terror. First, you’ll intercept the alien subs and shoot them down. Then, you’ll command a sub-aqua mission using the ‘Battlescape’ display. This view will display only what your aquanauts can see, allowing danger to creep up on the unsuspecting. \n \nSuccessfully completing Alien Submarine Assault missions allows X-COM scientists to clear the sites of artifacts and begin researching alien technology. On completion, Engineers can reproduce superior weapons to better attack subs. Soon you will be fighting the aliens with their own technology. A special UFOpaedia will contain all the information gathered from your missions."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {524,
     %{
       developers: [
         %{id: 71, name: "Raven Software"},
         %{id: 1735, name: "Runecraft"},
         %{id: 699, name: "Pipe Dream Interactive"},
         %{id: 106, name: "Loki Software"}
       ],
       franchises: [],
       id: 3111,
       name: "Soldier of Fortune",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 8, name: "PlayStation 2"},
         %{id: 23, name: "Dreamcast"}
       ],
       poster: %{
         id: "qnym0ghqiaxthsvl1zrf",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/qnym0ghqiaxthsvl1zrf.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/qnym0ghqiaxthsvl1zrf.jpg"
       },
       publishers: [
         %{id: 106, name: "Loki Software"},
         %{id: 66, name: "Activision"},
         %{id: 667, name: "Crave Entertainment"},
         %{id: 700, name: "Majesco Entertainment"},
         %{id: 115, name: "Codemasters"}
       ],
       release_date: ~U[2000-02-29 00:00:00Z],
       short_description:
         "John Mullins, working for a U.S.-based mercenary (\"soldier of fortune\") organization known only as \"The Shop\", and his partner, Aaron \"Hawk\" Parsons, are assigned to prevent the nukes from falling into the wrong hands, and stop the terrorists in their plans."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {515,
     %{
       developers: [%{id: 498, name: "Pyro Studios"}],
       franchises: [],
       id: 879,
       name: "Commandos: Behind Enemy Lines",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "ogtry7xroye8zg5jhjqw",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/ogtry7xroye8zg5jhjqw.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/ogtry7xroye8zg5jhjqw.jpg"
       },
       publishers: [%{id: 4, name: "Eidos Interactive"}],
       release_date: ~U[1998-07-31 00:00:00Z],
       short_description:
         "Engage in the ultimate battle of wits and wills with the most ruthless military force in history. Set in the backdrop of WWII, Commandos is a real-time tactical wargame that puts you in command of a squad of elite Allied Commandos whose job is to complete 24 dangerous missions behind enemy lines. Your goal is to thwart the German war effort by means of sabotage and tactical genius.This action-packed strategy war game is set apart by its revolutionary AI, and the ability to control 6 individual commandos, each with a specific skill, as they infiltrate hostile territories and engage in intense combat. Your perilous missions will take you from the parched desert of North Africa to banks of the Rhine, the mountainous fjords of Norway, and the beaches of Normandy.Experience the most realistic, visually stunning graphics with accurate 3D models of more than 350 structures, vehicles, and weapons from the WWII era."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {15,
     %{
       developers: [%{id: 857, name: "ThatGameCompany"}],
       franchises: [],
       id: 1352,
       name: "Journey",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 39, name: "iOS"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"}
       ],
       poster: %{
         id: "co1q8q",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1q8q.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1q8q.jpg"
       },
       publishers: [%{id: 45, name: "Sony Computer Entertainment, Inc. (SCEI)"}],
       release_date: ~U[2012-03-13 00:00:00Z],
       short_description:
         "In Journey the player controls a robed figure in a vast desert, traveling towards a mountain in the distance. Other players on the same journey can be discovered, and two players can meet and assist each other, but they cannot communicate via speech or text and cannot see each other's names. The only form of communication between the two is a musical chime. This chime also transforms dull, stiff pieces of cloth found throughout the levels into vibrant red, affecting the game world and allowing the player to progress through the levels. The robed figure wears a trailing scarf, which when charged by approaching floating pieces of cloth, briefly allows the player to float through the air.\n\nThe developers sought to evoke in the player a sense of smallness and wonder, and to forge an emotional connection between them and the anonymous players they meet along the way. The music, composed by Austin Wintory, dynamically responds to the player's actions, building a single theme to represent the game's emotional arc throughout the story. Reviewers of the game praised the visual and auditory art as well as the sense of companionship created by playing with a stranger, calling it a moving and emotional experience. Journey won several \"game of the year\" awards and received several other awards and nominations, including a Best Score Soundtrack for Visual Media nomination for the 2013 Grammy Awards."
     }, %{id: 48, name: "PlayStation 4"}},
    {10,
     %{
       developers: [%{id: 4712, name: "Ustwo"}],
       franchises: [],
       id: 36749,
       name: "Monument Valley 2",
       platforms: [%{id: 34, name: "Android"}, %{id: 39, name: "iOS"}],
       poster: %{
         id: "owjbysdq5hcdhnj09yzv",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/owjbysdq5hcdhnj09yzv.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/owjbysdq5hcdhnj09yzv.jpg"
       },
       publishers: [%{id: 4712, name: "Ustwo"}],
       release_date: ~U[2017-05-30 00:00:00Z],
       short_description:
         "Guide a mother and her child as they embark on a journey through magical architecture, discovering illusionary pathways and delightful puzzles as you learn the secrets of the Sacred Geometry."
     }, %{id: 39, name: "iOS"}},
    {542,
     %{
       developers: [%{id: 59, name: "Blizzard North"}, %{id: 60, name: "Climax Group"}],
       franchises: [],
       id: 125,
       name: "Diablo",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1mgg",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mgg.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mgg.jpg"
       },
       publishers: [
         %{id: 51, name: "Blizzard Entertainment"},
         %{id: 1, name: "Electronic Arts"},
         %{id: 252, name: "Square Electronic Arts"},
         %{id: 651, name: "Sourcenext"}
       ],
       release_date: ~U[1996-12-31 00:00:00Z],
       short_description:
         "An isometric strategy RPG that takes place in and below the town of Tristram. Gothic fantasy weapons and spells are used to defeat hordes of monsters from hell through randomized dungeon levels, continuously gaining experience points, gold, and a variety of equipment to bolster the hero's monster-killing potency along the way."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {401,
     %{
       developers: [%{id: 7260, name: "Night School Studio"}],
       franchises: [],
       id: 14587,
       name: "Oxenfree",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 39, name: "iOS"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1jkf",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1jkf.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1jkf.jpg"
       },
       publishers: [%{id: 7260, name: "Night School Studio"}],
       release_date: ~U[2016-01-15 00:00:00Z],
       short_description:
         "Oxenfree is a supernatural adventure game. Rites of passage and Senior year traditions set the stage for a group of friends sneaking off to Edwards Island, an old military outpost with no phone service. Players will take on the role of Alex as she brings her new stepbrother Jonas to an overnight party gone horribly wrong. Inspired by classic cult films like Stand by Me and Poltergeist, Oxenfree is an adventure that pulls from the past but looks to the present. “It’s a coming of age story where players control how their hero comes of age,” says Sean Krankel, co-founder of Night School. “We’re drawing on the fond and mortifying aspects of being in your late teens, and setting it against a dangerous and ghostly backdrop.”"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {595,
     %{
       developers: [%{id: 765, name: "Intelligent Systems Co., Ltd."}],
       franchises: [%{id: 769, name: "Fire Emblem"}],
       id: 26845,
       name: "Fire Emblem: Three Houses",
       platforms: [%{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "co1n8t",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1n8t.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1n8t.jpg"
       },
       publishers: [%{id: 70, name: "Nintendo"}],
       release_date: ~U[2019-07-26 00:00:00Z],
       short_description:
         "Here, order is maintained by the Church of Seiros, which hosts the prestigious Officer’s Academy within its headquarters. You are invited to teach one of its three mighty houses, each comprised of students brimming with personality and represented by a royal from one of three territories. As their professor, you must lead your students in their academic lives and in turn-based, tactical RPG battles wrought with strategic, new twists to overcome. Which house, and which path, will you choose?"
     }, %{id: 130, name: "Nintendo Switch"}},
    {245,
     %{
       developers: [%{id: 26, name: "Square Enix"}, %{id: 27, name: "Eidos Montréal"}],
       franchises: [],
       id: 9498,
       name: "Deus Ex: Mankind Divided",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1qqz",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qqz.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qqz.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}],
       release_date: ~U[2016-08-23 00:00:00Z],
       short_description:
         "Deus Ex: Mankind Divided directly follows the aftermath of the Aug Incident, a day when mechanically augmented citizens all over the world were stripped of control over their minds and bodies, resulting in the deaths of millions of innocents. The year is now 2029, and the golden era of augmentations is over. Mechanically augmented humans have been deemed outcasts and segregated from the rest of society. Crime and acts of terror serve as a thin veil to cover up an overarching conspiracy aimed at controlling the future of mankind…"
     }, %{id: 48, name: "PlayStation 4"}},
    {537,
     %{
       developers: [%{id: 14, name: "Bullfrog Productions"}],
       franchises: [],
       id: 35,
       name: "Dungeon Keeper",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"},
         %{id: 34, name: "Android"}
       ],
       poster: %{
         id: "co1ocf",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ocf.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ocf.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[1997-06-26 00:00:00Z],
       short_description:
         "Dungeon Keeper is a strategy video game in which the player attempts to build and manage a dungeon or lair while protecting it from invading 'hero' characters intent on stealing the player's accumulated treasures and killing various monsters. This was Peter Molyneux's final project with Bullfrog before he left the company in August 1997 to form Lionhead Studios. \n \nThe player uses a mouse, represented in-game as a hand, to interact with a bar on the left-hand side of the screen, allowing them to select which rooms to build and which spells to cast. The player can also use the hand to pick up creatures and objects in the dungeon and carry them around, allowing for tactics such as gathering an assault force and dropping off the creatures en masse once a foothold has been established. The hand also allows the player to \"slap\" objects and thereby interact with them: creatures will hurry up when slapped, some traps will be triggered and prisoners in the Torture Chamber can be tortured. \n \nThe main game view is in isometric perspective; this view can be zoomed and rotated. The player also has the option of possessing one of their creatures, and seeing the dungeon from that creature's first-person perspective, as well as using their attacks and abilities. The map is divided into a grid of rectangles, most of which are invisible. A smaller part of the map is shown as a minimap in the top left corner of the screen. \n \nA world map is also available, and at the beginning of the game the player is allocated one of the 20 regions of a fictional, idyllic country to destroy. As the player progresses through these regions, each of which represents a level of the game, the areas previously conquered will appear ransacked, twisted, and evil. Before starting a new level, the Mentor will tell the player about the current region and its attributes. After completing a level, the Mentor will talk about the \"improvement\" of the destroyed region: \"The streets run with the blood of the slain. Screams of pain and howls of anguish rip the night air like a vengeful siren's song. This really is somewhere you can take the kids for the weekend.\" \n \nThe Dungeon Heart represents the Dungeon Keeper's own link to the world. If it is destroyed, the player loses the level, and must restart. Along with the heart, the player begins with a small number of imps, the generic work force for all dungeon activities: they can dig tunnels into the surrounding soil, capture enemy rooms and Portals, mine gold and gems, set traps, and even attack when desperate or threatened. Slapping creatures forces them to work faster for a while, but removes some of their health and happiness. \n \nOnce the Imps are busily working, the player must then set up a basic infrastructure: Lairs for monsters, a Hatchery (where chickens, which serve as food for the minions, are bred), and a Treasury for storing gold. After connecting the dungeon to a \"Portal\", monsters will arrive. As the game progresses, the player moves along a technology tree, unlocking further rooms. \n \nThe dungeon has a fleshed-out ecology: some creatures are natural enemies. Flies and Spiders are often found at odds with one another, while a Horned Reaper, if it has gone berserk, will attack all creatures in its path. The goals for each level are fairly straightforward: they generally fall along the lines of eliminating the heroic force or destroying all other Dungeon Keepers on the level."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {118,
     %{
       developers: [%{id: 852, name: "Platinum Games"}],
       franchises: [],
       id: 11208,
       name: "NieR: Automata",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "qhok1pi6egmfizjjii7r",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/qhok1pi6egmfizjjii7r.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/qhok1pi6egmfizjjii7r.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}],
       release_date: ~U[2017-02-23 00:00:00Z],
       short_description:
         "NieR: Automata is an upcoming action role-playing game developed by PlatinumGames and published by Square Enix for the PlayStation 4. \n \nThe game is set in the same universe as NieR, a spin-off of the Drakengard series, and takes place several thousand years after the events of that game. Humanity has fled to the moon to escape an invading machine army from another world. Combat androids called YoRHa remain on the planet to fight in a proxy war against the invaders."
     }, %{id: 48, name: "PlayStation 4"}},
    {260,
     %{
       developers: [%{id: 7466, name: "Paradox Development Studio"}],
       franchises: [],
       id: 15894,
       name: "Hearts of Iron IV",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "co1j86",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1j86.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1j86.jpg"
       },
       publishers: [%{id: 517, name: "Paradox Interactive"}],
       release_date: ~U[2016-06-06 00:00:00Z],
       short_description:
         "Victory is at your fingertips! Your ability to lead your nation is your supreme weapon, the strategy game Hearts of Iron IV lets you take command of any nation in World War II; the most engaging conflict in world history. \n \nFrom the heart of the battlefield to the command center, you will guide your nation to glory and wage war, negotiate or invade. You hold the power to tip the very balance of WWII. It is time to show your ability as the greatest military leader in the world. Will you relive or change history? Will you change the fate of the world?"
     }, %{id: 14, name: "Mac"}},
    {454,
     %{
       developers: [%{id: 36, name: "Frictional Games"}],
       franchises: [],
       id: 9727,
       name: "SOMA",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "m6bll6ci6sy7ollxttj1",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/m6bll6ci6sy7ollxttj1.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/m6bll6ci6sy7ollxttj1.jpg"
       },
       publishers: [%{id: 36, name: "Frictional Games"}],
       release_date: ~U[2015-09-22 00:00:00Z],
       short_description:
         "SOMA is a sci-fi horror game from Frictional Games, creators of the groundbreaking Amnesia and Penumbra series. \n \nThe radio is dead, food is running out, and the machines have started to think they are people. Underwater facility PATHOS-II has suffered an intolerable isolation and we’re going to have to make some tough decisions. What can be done? What makes sense? What is left to fight for? SOMA is a sci-fi horror game from Frictional Games, the creators of Amnesia: The Dark Descent. It is an unsettling story about identity, consciousness, and what it means to be human."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {7,
     %{
       developers: [%{id: 401, name: "Naughty Dog"}],
       franchises: [],
       id: 6036,
       name: "The Last of Us Remastered",
       platforms: [%{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1ile",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1ile.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1ile.jpg"
       },
       publishers: [%{id: 45, name: "Sony Computer Entertainment, Inc. (SCEI)"}],
       release_date: ~U[2014-07-29 00:00:00Z],
       short_description:
         "Winner of over 200 game of the year awards, The Last of Us has been remastered for the PlayStation®4. Now featuring higher resolution character models, improved shadows and lighting, in addition to several other gameplay improvements. \n \nAbandoned cities reclaimed by nature. A population decimated by a modern plague. Survivors are killing each other for food, weapons whatever they can get their hands on. Joel, a brutal survivor, and Ellie, a brave young teenage girl who is wise beyond her years, must work together if they hope to survive their journey across the US. \n \nThe Last of Us: Remastered includes the Abandoned Territories Map Pack, Reclaimed Territories Map Pack, and the critically acclaimed The Last of Us: Left Behind Single Player campaign. \n \nPS4 PRO ENHANCED: \n- PS4 Pro HD \n- Dynamic 4K Gaming \n- Greater Draw Distance \n- Visual FX \n- Vivid Textures \n- Deep Shadows \n- High Fidelity Assets \n- HDR"
     }, %{id: 48, name: "PlayStation 4"}},
    {127,
     %{
       developers: [%{id: 403, name: "Sucker Punch Productions"}],
       franchises: [],
       id: 1941,
       name: "Infamous: Second Son",
       platforms: [%{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1izy",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1izy.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1izy.jpg"
       },
       publishers: [%{id: 45, name: "Sony Computer Entertainment, Inc. (SCEI)"}],
       release_date: ~U[2014-03-21 00:00:00Z],
       short_description:
         "inFAMOUS Second Son, a PlayStation 4 exclusive , brings you an action adventure game where surrounded by a society that fears them, superhumans are ruthlessly hunted down and caged by the Department of Unified Protection. Step into a locked-down Seattle as Delsin Rowe, who has recently discovered his superhuman power and is now capable of fighting back against the oppressive DUP. Enjoy your power as you choose how you will push your awesome abilities to the limit and witness the consequences of your actions as they affect the city and people around you."
     }, %{id: 48, name: "PlayStation 4"}},
    {517,
     %{
       developers: [%{id: 6424, name: "Nival"}],
       franchises: [],
       id: 13156,
       name: "Evil Islands: Curse of the Lost Soul",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "mbpd2ndysvcf6b9jmmla",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/mbpd2ndysvcf6b9jmmla.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/mbpd2ndysvcf6b9jmmla.jpg"
       },
       publishers: [%{id: 6964, name: "1C duplicate"}],
       release_date: ~U[2000-10-20 00:00:00Z],
       short_description:
         "Evil Islands is a PC game by Nival Interactive that combines role-playing, stealth, and real-time strategy. It is the third game of the Allods franchise, after Rage of Mages and Rage of Mages 2: Necromancer. Evil Islands introduces a new interface and full 3D graphics."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {244,
     %{
       developers: [%{id: 1242, name: "MachineGames"}],
       franchises: [],
       id: 2031,
       name: "Wolfenstein: The New Order",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 36, name: "Xbox Live Arcade"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1r74",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r74.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r74.jpg"
       },
       publishers: [%{id: 28, name: "Bethesda Softworks LLC"}],
       release_date: ~U[2014-05-20 00:00:00Z],
       short_description:
         "Wolfenstein: The New Order will be single-player-only. The game follows a standard first-person shooter formula with the player taking on enemies over the course of a level. The New Order utilizes a health system in which the player's health is divided into separate sections that regenerate; if an entire section is lost, the player must use a health pack to replenish the missing health, in a similar fashion to games such as The Chronicles of Riddick: Escape from Butcher Bay and Resistance: Fall of Man. The player also has access to a non-limited weapon inventory, dual wielding certain weapons, as well as the ability to lean around, over and under cover, and perform a combat slide. Certain weapons also have special abilities such as a laser cannon which transforms into a cutting tool, and some turrets can be pulled from their stationary position and carried around. Semi-destructible environments have also been confirmed."
     }, %{id: 48, name: "PlayStation 4"}},
    {497,
     %{
       developers: [%{id: 309, name: "2015"}],
       franchises: [],
       id: 326,
       name: "Medal of Honor: Allied Assault",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1qz9",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qz9.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qz9.jpg"
       },
       publishers: [
         %{id: 73, name: "Aspyr Media"},
         %{id: 1, name: "Electronic Arts"},
         %{id: 4132, name: "icculus.org"}
       ],
       release_date: ~U[2002-01-22 00:00:00Z],
       short_description:
         "Set during World War II, Medal of Honor: Allied Assault chronicles the fictional exploits of Lt. Mike Powell as he battles his way from the shores of Africa to the shores of France to the heart of Nazi Germany."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {539,
     %{
       developers: [%{id: 13919, name: "Alternative Reality Technologies"}],
       franchises: [],
       id: 51199,
       name: "Dark Colony",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "uukibsbv3frlrgcta6xy",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/uukibsbv3frlrgcta6xy.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/uukibsbv3frlrgcta6xy.jpg"
       },
       publishers: [%{id: 528, name: "SSI (Strategic Simulations, Inc.)"}],
       release_date: ~U[1997-02-01 00:00:00Z],
       short_description:
         "Dark Colony is a real-time strategy with heavy emphasis on the actual combat. Resource gathering, base construction and unit production have been made as simple and fast as possible, allowing the player to focus on decimating the enemy armies. Ancient artifacts, available in some of the missions, provide unique options for beating the odds, even when they seem to be against you (and they often will)."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {472,
     %{
       developers: [%{id: 126, name: "Bethesda Game Studios"}],
       franchises: [%{id: 1034, name: "Fallout"}],
       id: 15,
       name: "Fallout 3",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "co1qkz",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qkz.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qkz.jpg"
       },
       publishers: [%{id: 245, name: "ZeniMax Media"}, %{id: 28, name: "Bethesda Softworks LLC"}],
       release_date: ~U[2008-10-28 00:00:00Z],
       short_description:
         "Fallout 3 from the creators of the award-winning Oblivion, featuring one of the most realized game worlds ever created. Create any kind of character you want and explore the open wastes of post-apocalyptic Washington D.C. Every minute is a fight for survival as you encounter Super Mutants, Ghouls, Raiders and other dangers of the Wasteland. Prepare for the future. \n \nThe third game in the Fallout series, Fallout 3 is a singleplayer action role-playing game (RPG) set in a post-apocalyptic Washington DC. Combining the horrific insanity of the Cold War era theory of mutually assured destruction gone terribly wrong, with the kitschy naivety of American 1950s nuclear propaganda, Fallout 3 will satisfy both players familiar with the popular first two games in its series as well as those coming to the franchise for the first time."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {460,
     %{
       developers: [%{id: 168, name: "Epic Games, Inc."}],
       franchises: [],
       id: 15263,
       name: "Unreal Tournament",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "co1i2j",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1i2j.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1i2j.jpg"
       },
       publishers: [%{id: 168, name: "Epic Games, Inc."}],
       release_date: ~U[2016-05-01 00:00:00Z],
       short_description:
         "This is an early version of the Unreal Tournament experience, featuring new content and returning classics. There’s still a lot of work to be done, but you’re able to participate, today, and earn in-game rewards available only to Pre-Alpha participants."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {392,
     %{
       developers: [%{id: 7156, name: "Rockstar Studios"}],
       franchises: [%{id: 884, name: "Red Dead"}],
       id: 25076,
       name: "Red Dead Redemption 2",
       platforms: [%{id: 48, name: "PlayStation 4"}, %{id: 49, name: "Xbox One"}],
       poster: %{
         id: "co1q1f",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1q1f.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1q1f.jpg"
       },
       publishers: [%{id: 139, name: "Take-Two Interactive"}, %{id: 29, name: "Rockstar Games"}],
       release_date: ~U[2018-10-26 00:00:00Z],
       short_description:
         "Developed by the creators of Grand Theft Auto V and Red Dead Redemption, Red Dead Redemption 2 is an epic tale of life in America’s unforgiving heartland. The game's vast and atmospheric world will also provide the foundation for a brand new online multiplayer experience."
     }, %{id: 48, name: "PlayStation 4"}},
    {534,
     %{
       developers: [
         %{id: 543, name: "Rage Software"},
         %{id: 1169, name: "David A. Palmer Productions"},
         %{id: 360, name: "Logicware"},
         %{id: 184, name: "id Software"}
       ],
       franchises: [],
       id: 673,
       name: "Doom",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"},
         %{id: 19, name: "Super Nintendo Entertainment System (SNES)"},
         %{id: 24, name: "Game Boy Advance"},
         %{id: 30, name: "Sega 32X"},
         %{id: 32, name: "Sega Saturn"},
         %{id: 36, name: "Xbox Live Arcade"},
         %{id: 39, name: "iOS"},
         %{id: 50, name: "3DO Interactive Multiplayer"},
         %{id: 58, name: "Super Famicom"},
         %{id: 62, name: "Atari Jaguar"}
       ],
       poster: %{
         id: "napawx0fxrjpfd7jvpft",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/napawx0fxrjpfd7jvpft.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/napawx0fxrjpfd7jvpft.jpg"
       },
       publishers: [
         %{id: 66, name: "Activision"},
         %{id: 205, name: "GT Interactive"},
         %{id: 4112, name: "Soft Bank"},
         %{id: 4113, name: "Art Data Interactive"},
         %{id: 4114, name: "Bashou House"},
         %{id: 665, name: "Williams Entertainment"},
         %{id: 1271, name: "Ocean Software"},
         %{id: 191, name: "Imagineer"},
         %{id: 28, name: "Bethesda Softworks LLC"},
         %{id: 82, name: "Atari"},
         %{id: 184, name: "id Software"},
         %{id: 112, name: "Sega"}
       ],
       release_date: ~U[1993-12-10 00:00:00Z],
       short_description:
         "A sci-fi FPS in which a space mercenary searches for his lost friend from the box art. \n \nThings aren't looking too good. You'll never navigate off the planet on your own. Plus, all the heavy weapons have been taken by the assault team leaving you with only a pistol. If you only could get your hands around a plasma rifle or even a shotgun you could take a few down on your way out. Whatever killed your buddies deserves a couple of pellets in the forehead. Securing your helmet, you exit the landing pod. Hopefully you can find more substantial firepower somewhere within the station. As you walk through the main entrance of the base, you hear animal-like growls echoing through the distant corridors. They know you're here. There's no turning back now."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {491,
     %{
       developers: [%{id: 184, name: "id Software"}],
       franchises: [],
       id: 280,
       name: "Doom 3",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 11, name: "Xbox"},
         %{id: 14, name: "Mac"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "ma6zezuzeklj3ei1sqfw",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/ma6zezuzeklj3ei1sqfw.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/ma6zezuzeklj3ei1sqfw.jpg"
       },
       publishers: [%{id: 66, name: "Activision"}, %{id: 73, name: "Aspyr Media"}],
       release_date: ~U[2004-08-03 00:00:00Z],
       short_description:
         "A massive demonic invasion has overwhelmed the Union Aerospace Corporation's (UAC) Mars Research Facility, leaving only chaos and horror in its wake. As one of only a few survivors, you must fight your way to hell and back against a horde of evil monsters. The path is dark and dangerous, but you'll have an array of weapons--including a pistol, a chainsaw, grenades, and more--to use for protection."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {486,
     %{
       developers: [%{id: 486, name: "Sports Interactive"}],
       franchises: [],
       id: 946,
       name: "Football Manager 2008",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"},
         %{id: 38, name: "PlayStation Portable"}
       ],
       poster: %{
         id: "hkkncli9zeaofmm0kk9v",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/hkkncli9zeaofmm0kk9v.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/hkkncli9zeaofmm0kk9v.jpg"
       },
       publishers: [%{id: 112, name: "Sega"}],
       release_date: ~U[2007-10-18 00:00:00Z],
       short_description:
         "Football Manager 2008 is the principal title of the 2008 edition of the Football Manager series of football management simulation games by Sports Interactive. The version for the United States and Canada is entitled Worldwide Soccer Manager 2008, while the South American version is Fútbol Manager 2008. There are over 5,000 playable teams from more than 50 countries.[2] The demo for Football Manager 2008 was released on 30 September 2007.[3] \n \nThe game was originally intended to be released on 19 October 2007, but due to early shipments by many retailers carrying their game, Sports Interactive moved the release date to 18 October 2007.[1] \n \nSeveral problems surfaced in the game, most of which had been reported to SI Games via their issues forum, and as a result a \"Beta Patch\" was released. This patch did not fix all problems, but was released early to fix major issues. A full patch was set to be released on 9 November 2007 but was delayed, and was finally released on 22 November 2007. The second and final patch was released on 14 February 2008 and updated on 20 February to attempt to fix three major issues that remained in the game. As with previous games, the patch updates the game's database with all the latest transfers and fixes many of the game's remaining bugs."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {368,
     %{
       developers: [%{id: 12298, name: "Thekla, Inc"}],
       franchises: [],
       id: 5601,
       name: "The Witness",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 39, name: "iOS"},
         %{id: 45, name: "PlayStation Network"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1nc1",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nc1.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nc1.jpg"
       },
       publishers: [%{id: 12298, name: "Thekla, Inc"}],
       release_date: ~U[2016-01-26 00:00:00Z],
       short_description:
         "The Witness is an exploration-puzzle game. The game is being developed by a small, independent team, a mix of full-timers and contractors."
     }, %{id: 48, name: "PlayStation 4"}},
    {512,
     %{
       developers: [%{id: 277, name: "EA Canada"}, %{id: 350, name: "EA Seattle"}],
       franchises: [],
       id: 92,
       name: "Need for Speed III: Hot Pursuit",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 7, name: "PlayStation"}],
       poster: %{
         id: "v2dmlrtbmee9gean1ncm",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/v2dmlrtbmee9gean1ncm.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/v2dmlrtbmee9gean1ncm.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[1998-03-25 00:00:00Z],
       short_description:
         "Drive some of the most exotic cars in illegal street race on many different tracks, while trying not to be caught by police!"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {530,
     %{
       developers: [%{id: 575, name: "Impressions Games"}],
       franchises: [],
       id: 7510,
       name: "Pharaoh",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "qzvffnysjdmjcd2mhnao",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/qzvffnysjdmjcd2mhnao.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/qzvffnysjdmjcd2mhnao.jpg"
       },
       publishers: [%{id: 24, name: "Sierra Entertainment"}],
       release_date: ~U[1999-12-31 00:00:00Z],
       short_description:
         "Pharaoh is a Strategy game, developed by Impressions Games and published by Sierra Entertainment, which was released in 1999."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {499,
     %{
       developers: [
         %{id: 239, name: "Gas Powered Games"},
         %{id: 378, name: "Westlake Interactive"}
       ],
       franchises: [],
       id: 329,
       name: "Dungeon Siege",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "co1np1",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1np1.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1np1.jpg"
       },
       publishers: [%{id: 53, name: "Microsoft Game Studios"}, %{id: 130, name: "MacSoft Games"}],
       release_date: ~U[2002-04-05 00:00:00Z],
       short_description:
         "Dungeon Siege combines the immersive elements of a role-playing game with over-the-top intensity and non-stop action. Dungeon Siege plunges you into a continuous 3D fantasy world where you face off against an army of evil that has been unleashed."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {243,
     %{
       developers: [%{id: 795, name: "Ninja Theory"}],
       franchises: [],
       id: 7603,
       name: "Hellblade: Senua's Sacrifice",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "glamt1yluduscermfoez",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/glamt1yluduscermfoez.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/glamt1yluduscermfoez.jpg"
       },
       publishers: [%{id: 795, name: "Ninja Theory"}],
       release_date: ~U[2017-08-08 00:00:00Z],
       short_description:
         "On Hellblade, we will double down on what we do best to give you a deeper character in a twisted world with brutal, uncompromising, combat. \n \nWe are embracing the creative spirit that comes with independence without letting go of the stunning production values that we are known for. It’s not indie, it’s not AAA. This is a third way. its independent AAA. \n \nIt’s about making a more focused game experience that isn’t trying to be all things to all people but satisfies a particular gaming itch. It’s about being in command of our creativity so that we can give you what you want from us at a lower price. \n \nIt’s very early days in the project but we are opening our doors and inviting you to join us every step of the way. We want to show you how we make this game warts and all so that you can be part of this journey. \n \nThe game is dedicated to our fans and supporters."
     }, %{id: 48, name: "PlayStation 4"}},
    {461,
     %{
       developers: [%{id: 70, name: "Nintendo"}, %{id: 70, name: "Nintendo"}],
       franchises: [],
       id: 4600,
       name: "Excitebike",
       platforms: [
         %{id: 5, name: "Wii"},
         %{id: 18, name: "Nintendo Entertainment System (NES)"},
         %{id: 24, name: "Game Boy Advance"},
         %{id: 41, name: "Wii U"},
         %{id: 47, name: "Virtual Console (Nintendo)"},
         %{id: 52, name: "Arcade"},
         %{id: 77, name: "Sharp X1"},
         %{id: 125, name: "PC-8801"}
       ],
       poster: %{
         id: "qnxgsxijvvejjrjrgxdf",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/qnxgsxijvvejjrjrgxdf.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/qnxgsxijvvejjrjrgxdf.jpg"
       },
       publishers: [%{id: 70, name: "Nintendo"}, %{id: 864, name: "Hudson Soft"}],
       release_date: ~U[1984-11-30 00:00:00Z],
       short_description:
         "Excitebike (エキサイトバイク Ekisaitobaiku) is a motocross racing video game franchise made by Nintendo. It first debuted as a game for the Famicom in Japan in 1984 and as a launch title for the NES in 1985. It is the first game of the Excite series, succeeded by its direct sequel Excitebike 64, its spiritual successors Excite Truck and Excitebots: Trick Racing, and the WiiWare title Excitebike: World Rally. 3D Classics: Excitebike, a 3D remake of the original game, was free for a limited time to promote the launch of the Nintendo eShop in June 2011, and has since been available for $5.99."
     }, %{id: 18, name: "Nintendo Entertainment System (NES)"}},
    {11,
     %{
       developers: [%{id: 1843, name: "Guerrilla Games"}],
       franchises: [],
       id: 11156,
       name: "Horizon Zero Dawn",
       platforms: [%{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1izx",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1izx.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1izx.jpg"
       },
       publishers: [%{id: 45, name: "Sony Computer Entertainment, Inc. (SCEI)"}],
       release_date: ~U[2017-02-28 00:00:00Z],
       short_description:
         "Horizon Zero Dawn, an exhilarating new action role playing game exclusively for the PlayStation 4 system, developed by the award winning Guerrilla Games, creatos of PlayStation's venerated Killzone franchise. As Horizon Zero Dawn's main protagonist Aloy, a skilled hunter, explore a vibrant and lush world inhabited by mysterious mechanized creatures."
     }, %{id: 48, name: "PlayStation 4"}},
    {310,
     %{
       developers: [%{id: 5052, name: "Moon Studios"}],
       franchises: [],
       id: 7344,
       name: "Ori and the Blind Forest",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 49, name: "Xbox One"}],
       poster: %{
         id: "co1nc6",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nc6.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nc6.jpg"
       },
       publishers: [%{id: 1010, name: "Microsoft Studios"}],
       release_date: ~U[2015-03-11 00:00:00Z],
       short_description:
         "The forest of Nibel is dying. After a powerful storm sets a series of devastating events in motion, an unlikely hero must journey to find his courage and confront a dark nemesis to save his home. Ori and the Blind Forest tells the tale of a young orphan destined for heroics, through a visually stunning action-platformer crafted by Moon Studios for Xbox One and PC. Featuring hand-painted artwork, meticulously animated character performance, and a fully orchestrated score, Ori and the Blind Forest explores a deeply emotional story about love and sacrifice, and the hope that exists in us all."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {66,
     %{
       developers: [%{id: 1365, name: "Lucas Pope"}],
       franchises: [],
       id: 2935,
       name: "Papers, Please",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 39, name: "iOS"},
         %{id: 46, name: "PlayStation Vita"}
       ],
       poster: %{
         id: "co1qkp",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qkp.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qkp.jpg"
       },
       publishers: [%{id: 15527, name: "3909"}],
       release_date: ~U[2013-08-08 00:00:00Z],
       short_description:
         "Papers, Please was developed by Lucas Pope beginning in November, 2012 using the Haxe programming language and the NME framework, both open-source. As an American living in Japan, Pope dealt with immigration in his international travels and thought the experience, which he describes as \"tense\", could be made into a fun game. Before release, Pope had set up a name submission form for the public, where people could submit their own names to be randomly assigned to scripted characters in the game. Papers, Please was submitted to Steam Greenlight on April 11, 2013 and was greenlit on May 1."
     }, %{id: 14, name: "Mac"}},
    {64,
     %{
       developers: [%{id: 377, name: "Firaxis Games"}],
       franchises: [%{id: 1064, name: "X-COM"}],
       id: 1318,
       name: "XCOM: Enemy Unknown",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1mz6",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mz6.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mz6.jpg"
       },
       publishers: [%{id: 8, name: "2K Games"}, %{id: 23, name: "Feral Interactive"}],
       release_date: ~U[2012-10-09 00:00:00Z],
       short_description:
         "XCOM: Enemy Unknown will place you in control of a secret paramilitary organization called XCOM. As the XCOM commander, you will defend against a terrifying global alien invasion by managing resources, advancing technologies, and overseeing combat strategies and individual unit tactics. \nThe original XCOM is widely regarded as one of the best games ever made and has now been re-imagined by the strategy experts at Firaxis Games. XCOM: Enemy Unknown will expand on that legacy with an entirely new invasion story, enemies and technologies to fight aliens and defend Earth. \nYou will control the fate of the human race through researching alien technologies, creating and managing a fully operational base, planning combat missions and controlling soldier movement in battle."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {332,
     %{
       developers: [%{id: 175, name: "Haemimont Games"}],
       franchises: [],
       id: 28574,
       name: "Surviving Mars",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "co1kvs",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1kvs.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1kvs.jpg"
       },
       publishers: [%{id: 517, name: "Paradox Interactive"}],
       release_date: ~U[2018-03-15 00:00:00Z],
       short_description:
         "Surviving Mars is a sci-fi city builder all about colonizing Mars and surviving the process. Choose a space agency for resources and financial support before determining a location for your colony. Build domes and infrastructure, research new possibilities and utilize drones to unlock more elaborate ways to shape and expand your settlement. Cultivate your own food, mine minerals or just relax by the bar after a hard day’s work. Most important of all, though, is keeping your colonists alive. Not an easy task on a strange new planet."
     }, %{id: 14, name: "Mac"}},
    {41,
     %{
       developers: [%{id: 26, name: "Square Enix"}],
       franchises: [%{id: 4, name: "Final Fantasy"}],
       id: 389,
       name: "Final Fantasy XIII",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "tovdsvddsaum1xbkvhhu",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/tovdsvddsaum1xbkvhhu.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/tovdsvddsaum1xbkvhhu.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}],
       release_date: ~U[2009-12-17 00:00:00Z],
       short_description:
         "As a deepening crisis threatens to plunge the floating world of Cocoon into chaos, a band of unsuspecting strangers find themselves branded enemies of the state. With the panicking population baying for their blood, and the military all too happy to oblige, they have no choice but to run for their lives. Join them on a desperate quest to challenge the forces controlling their fate, and prevent untold destruction. \n \nFeaturing an unforgettable storyline, a battle system blending action and strategy, cutting-edge visuals and awe-inspiring cinematic sequences, Final Fantasy XIII delivers the next step in the evolution of gaming."
     }, %{id: 12, name: "Xbox 360"}},
    {36,
     %{
       developers: [%{id: 365, name: "Rockstar North"}],
       franchises: [],
       id: 1020,
       name: "Grand Theft Auto V",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1nt4",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nt4.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nt4.jpg"
       },
       publishers: [%{id: 29, name: "Rockstar Games"}, %{id: 139, name: "Take-Two Interactive"}],
       release_date: ~U[2013-09-17 00:00:00Z],
       short_description:
         "The biggest, most dynamic and most diverse open world ever created, Grand Theft Auto V blends storytelling and gameplay in new ways as players repeatedly jump in and out of the lives of the game’s three lead characters, playing all sides of the game’s interwoven story."
     }, %{id: 12, name: "Xbox 360"}},
    {40,
     %{
       developers: [%{id: 412, name: "Codemasters Southam"}],
       franchises: [],
       id: 524,
       name: "Dirt 3",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "pun7d9tjhw7dj0lclqoo",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/pun7d9tjhw7dj0lclqoo.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/pun7d9tjhw7dj0lclqoo.jpg"
       },
       publishers: [%{id: 115, name: "Codemasters"}],
       release_date: ~U[2011-05-24 00:00:00Z],
       short_description:
         "Dirt 3 is a rallying video game and the third in the Dirt series of the Colin McRae Rally series, developed and published by Codemasters."
     }, %{id: 12, name: "Xbox 360"}},
    {33,
     %{
       developers: [%{id: 4712, name: "Ustwo"}],
       franchises: [],
       id: 8900,
       name: "Monument Valley",
       platforms: [
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"},
         %{id: 74, name: "Windows Phone"}
       ],
       poster: %{
         id: "cocbrvnx9rjxlexmt9hu",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/cocbrvnx9rjxlexmt9hu.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/cocbrvnx9rjxlexmt9hu.jpg"
       },
       publishers: [%{id: 4712, name: "Ustwo"}],
       release_date: ~U[2014-04-03 00:00:00Z],
       short_description:
         "In Monument Valley, the player leads the player-character princess Ida through mazes of optical illusions and impossible objects, which are referred to as \"sacred geometry\" in-game, as she journeys to be forgiven for something. The game is presented in isometric view, and the player interacts with the environment to find hidden passages as Ida progresses to the map's exit. Each of the ten levels has a different central mechanic. Interactions include moving platforms and pillar animals, and creating bridges. The player is indirectly cued through the game by design elements like color, and directly cued by crow people, who block Ida's path. Critics compared the game's visual style to a vibrant M. C. Escher drawing and Echochrome. The game includes a camera mode where the player can roam the level to compose screenshots. It includes filters à la Instagram."
     }, %{id: 39, name: "iOS"}},
    {580,
     %{
       developers: [%{id: 12052, name: "No Code"}],
       franchises: [],
       id: 110_807,
       name: "Observation",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1h33",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1h33.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1h33.jpg"
       },
       publishers: [%{id: 634, name: "Devolver Digital"}],
       release_date: ~U[2019-05-21 00:00:00Z],
       short_description:
         "Observation is a sci-fi thriller uncovering what happened to Dr. Emma Fisher, and the crew of her mission, through the lens of the station’s artificial intelligence S.A.M. Players assume the role of S.A.M. by operating the station’s control systems, cameras, and tools to assist Emma in discovering what is happening to the station, the vanished crew, and S.A.M. himself."
     }, %{id: 48, name: "PlayStation 4"}},
    {278,
     %{
       developers: [%{id: 250, name: "Square"}],
       franchises: [],
       id: 1802,
       name: "Chrono Trigger",
       platforms: [
         %{id: 5, name: "Wii"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 19, name: "Super Nintendo Entertainment System (SNES)"},
         %{id: 20, name: "Nintendo DS"},
         %{id: 34, name: "Android"},
         %{id: 39, name: "iOS"}
       ],
       poster: %{
         id: "co1r7m",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r7m.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r7m.jpg"
       },
       publishers: [%{id: 250, name: "Square"}],
       release_date: ~U[1995-03-11 00:00:00Z],
       short_description:
         "In this turn-based Japanese RPG, young Crono must travel through time through a misfunctioning teleporter to rescue his misfortunate companion and take part in an intricate web of past and present perils. The adventure that ensues soon unveils an evil force set to destroy the world, triggering Crono's race against time to change the course of history and bring about a brighter future."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {404,
     %{
       developers: [%{id: 7902, name: "Nintendo EPD"}],
       franchises: [%{id: 596, name: "The Legend of Zelda"}],
       id: 7346,
       name: "The Legend of Zelda: Breath of the Wild",
       platforms: [%{id: 41, name: "Wii U"}, %{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "co1p98",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1p98.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1p98.jpg"
       },
       publishers: [
         %{id: 2850, name: "Nintendo of America"},
         %{id: 4034, name: "Nintendo of Europe"},
         %{id: 70, name: "Nintendo"}
       ],
       release_date: ~U[2017-03-03 00:00:00Z],
       short_description:
         "Step into a world of discovery, exploration and adventure in The Legend of Zelda: Breath of the Wild, a boundary-breaking new game in the acclaimed series. Travel across fields, through forests and to mountain peaks as you discover what has become of the ruined kingdom of Hyrule in this stunning open-air adventure."
     }, %{id: 130, name: "Nintendo Switch"}},
    {38,
     %{
       developers: [%{id: 2, name: "BioWare"}, %{id: 222, name: "BioWare Edmonton"}],
       franchises: [],
       id: 73,
       name: "Mass Effect",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 45, name: "PlayStation Network"}
       ],
       poster: %{
         id: "co1r2w",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r2w.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r2w.jpg"
       },
       publishers: [%{id: 53, name: "Microsoft Game Studios"}, %{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2007-11-20 00:00:00Z],
       short_description:
         "What starts as a routine mission to an agrarian outpost quickly becomes the opening salvo in an epic war. As the newly appointed Executive Officer of the SSV Normandy, you'll assemble and lead an elite squad of heroes into battle after heart-pounding battle. Each decision you make will impact not only your fate, but the destiny of the entire galaxy in the Mass Effect trilogy. \n \nKey Features: \n \nIncredible, interactive storytelling. Create and customize your own character, from Commander Shepard's appearance and skills to a personalized arsenal. Unleash devastating abilities as you command and train. Your decisions will control the outcome of each mission, your relationships with your crew and ultimately the entire war. \n \nAn amazing universe to explore. From the massive Citadel to the harsh, radioactive landscape of the Krogan home world – the incredible breadth of the Mass Effect universe will blow you away. Travel to the farthest outposts aboard the SSV Normandy, the most technologically advanced ship in the galaxy. You'll follow the clues left by ancient civilizations, discover hidden bases with fantastic new tech and lead your hand-picked crew into explosive alien battles. \n \nEdge-of-your-seat excitement meets strategic combat. Find the perfect combination of squad-mates and weapons for each battle if you want to lead them to victory. Sun-Tzu's advice remains as pertinent in 2183 as it is today – know your enemy. You'll need different tactics for a squad of enemies with devastating biotic attacks than a heavily armored Geth Colossus so choose your teams wisely."
     }, %{id: 12, name: "Xbox 360"}},
    {569,
     %{
       developers: [%{id: 94, name: "EA Digital Illusions CE"}],
       franchises: [],
       id: 18320,
       name: "Battlefield 1",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1o58",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1o58.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1o58.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2016-10-21 00:00:00Z],
       short_description:
         "Discover classic Battlefield gameplay with epic multiplayer and an adventure-filled campaign. Experience the Dawn of All-Out War, Only in Battlefield 1. \n \nFight your way through epic battles going from tight urban combat in a besieged French city to big open spaces in the Italian Alps or frantic combats in the Arabic sand dunes. Experience large-scale battles as infantry or piloting vehicles on land, air and sea, from the tanks and bikes on the ground, to bi-planes and gigantic battleships. \n \nDiscover a new world at war through an adventure-filled campaign, or join in epic multiplayer battles with up to 64 players. Adapt your tactics and strategy to the earth-shattering, dynamic environments and destruction."
     }, %{id: 48, name: "PlayStation 4"}},
    {377,
     %{
       developers: [
         %{id: 103, name: "Black Hole Entertainment"},
         %{id: 2514, name: "Limbic Entertainment"},
         %{id: 794, name: "Virtuos"}
       ],
       franchises: [%{id: 458, name: "Might and Magic"}],
       id: 373,
       name: "Might & Magic: Heroes VI",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "co1nn6",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1nn6.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1nn6.jpg"
       },
       publishers: [%{id: 104, name: "Ubisoft Entertainment"}],
       release_date: ~U[2011-10-13 00:00:00Z],
       short_description:
         "The adventure in Heroes VI, starting 400 years before events in Heroes V, catapults a family of heroes into a fast-paced epic story where Angels plot to end -- once and for all -- an unfinished war with their ancient rivals, the Faceless. \nA legendary Archangel General is resurrected, but with his powers crippled. Plagued by horrible memories of the Elder Wars, he plots to recover his powers and take control of Ashan while destroying both Faceless and Demons in a series of carefully orchestrated attacks and betrayals. He underestimates, however, the power of the all-too-human Griffin dynasty."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {32,
     %{
       developers: [%{id: 21, name: "Irrational Games"}, %{id: 3023, name: "Virtual Programming"}],
       franchises: [],
       id: 538,
       name: "Bioshock Infinite",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"},
         %{id: 36, name: "Xbox Live Arcade"},
         %{id: 45, name: "PlayStation Network"}
       ],
       poster: %{
         id: "wdjzivj9h5w0k6anz2q7",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/wdjzivj9h5w0k6anz2q7.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/wdjzivj9h5w0k6anz2q7.jpg"
       },
       publishers: [%{id: 8, name: "2K Games"}],
       release_date: ~U[2013-02-26 00:00:00Z],
       short_description:
         "This first-person story-driven shooter and entry in the Bioshock franchise follows Booker DeWitt as he enters the floating independent (formerly US) city of Columbia in 1912 and attempts to retrieve a girl trapped in a tower by the city's self-proclaimed despot/prophet in order to erase his financial debt. Throughout the story, themes of violence, racism and fatalism are brought up."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {339,
     %{
       developers: [%{id: 4357, name: "SIE Santa Monica Studio"}],
       franchises: [],
       id: 19560,
       name: "God of War",
       platforms: [%{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1r6u",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r6u.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r6u.jpg"
       },
       publishers: [%{id: 10100, name: "Sony Interactive Entertainment"}],
       release_date: ~U[2018-04-20 00:00:00Z],
       short_description:
         "\"It is a new beginning for Kratos. Living as a man, outside the shadow of the gods, he seeks solitude in the unfamiliar lands of Norse mythology. With new purpose and his son at his side, Kratos must fight for survival as powerful forces threaten to disrupt the new life he has created...\""
     }, %{id: 48, name: "PlayStation 4"}},
    {501,
     %{
       developers: [%{id: 126, name: "Bethesda Game Studios"}],
       franchises: [],
       id: 56,
       name: "The Elder Scrolls III: Morrowind",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 11, name: "Xbox"}],
       poster: %{
         id: "ovcvmuzoszpazgfrbiun",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/ovcvmuzoszpazgfrbiun.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/ovcvmuzoszpazgfrbiun.jpg"
       },
       publishers: [
         %{id: 28, name: "Bethesda Softworks LLC"},
         %{id: 245, name: "ZeniMax Media"},
         %{id: 104, name: "Ubisoft Entertainment"}
       ],
       release_date: ~U[2002-05-01 00:00:00Z],
       short_description:
         "The Elder Scrolls III: Morrowind is an open world fantasy action role-playing video game developed by Bethesda Game Studios, and published by Bethesda Softworks and Ubisoft. It is the third installment in The Elder Scrolls series of games, following The Elder Scrolls II: Daggerfall, and preceding The Elder Scrolls IV: Oblivion. It was released in North America in 2002 for Microsoft Windows and the Xbox. \n \nThe main story takes place on Vvardenfell, an island in the Dunmer province of Morrowind, which lies in the empire of Tamriel and is far from the more civilized lands to the west and south that typified Daggerfall and Arena. The central quests concern the deity Dagoth Ur, housed within the volcanic Red Mountain, who seeks to gain power and break Morrowind free from Imperial reign."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {394,
     %{
       developers: [%{id: 747, name: "Tarsier Studios"}],
       franchises: [],
       id: 9174,
       name: "Little Nightmares",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "bvgcjfo6tu1qrqlonakl",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/bvgcjfo6tu1qrqlonakl.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/bvgcjfo6tu1qrqlonakl.jpg"
       },
       publishers: [%{id: 248, name: "Bandai Namco Entertainment"}],
       release_date: ~U[2017-04-28 00:00:00Z],
       short_description:
         "An atmospheric 3D side-scroller about a girl named Six and her attempts to escape the strange and hostile world of The Maw and its nightmarish facilities and inhabitants."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {331,
     %{
       developers: [%{id: 36, name: "Frictional Games"}],
       franchises: [],
       id: 111,
       name: "Amnesia: The Dark Descent",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "co1qq5",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qq5.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qq5.jpg"
       },
       publishers: [%{id: 36, name: "Frictional Games"}],
       release_date: ~U[2010-09-08 00:00:00Z],
       short_description:
         "Amnesia: The Dark Descent is a survival horror video game by Frictional Games. The game features a protagonist named Daniel exploring a dark and foreboding castle, while trying to maintain his sanity by avoiding monsters and other terrifying obstructions. The game was critically well received."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {109,
     %{
       developers: [%{id: 7466, name: "Paradox Development Studio"}],
       franchises: [],
       id: 2918,
       name: "Crusader Kings II",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1mwa",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mwa.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mwa.jpg"
       },
       publishers: [%{id: 517, name: "Paradox Interactive"}],
       release_date: ~U[2012-02-03 00:00:00Z],
       short_description:
         "The Dark Ages might be drawing to a close, but Europe is still in turmoil. Petty lords vie against beleaguered kings who struggle to assert control over their fragmented realms. The Pope calls for a Crusade to protect the Christians in the Holy Land even as he refuses to relinquish control over the investiture of bishops - and their riches. Now is the time for greatness. Expand your demesne and secure the future of your dynasty. Fill your coffers, appoint vassals, root out traitors and heretics, introduce laws and interact with hundreds of nobles, each with their own agenda.  \nA good lord will always need friends to support him. But beware, as loyal vassals can quickly turn to bitter rivals, and some might not be as reliable as they seem... Stand ready, and increase your prestige until the world whispers your name in awe. Do you have what it takes to become a Crusader King?  \nCrusader Kings II explores one of the defining periods in world history in an experience crafted by the masters of Grand Strategy. Medieval Europe is brought to life in this epic game of knights, schemes, and thrones..."
     }, %{id: 14, name: "Mac"}},
    {330,
     %{
       developers: [%{id: 1364, name: "The Chinese Room"}],
       franchises: [],
       id: 1882,
       name: "Amnesia: A Machine for Pigs",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"}
       ],
       poster: %{
         id: "dee99qs5aceqhizojivg",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/dee99qs5aceqhizojivg.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/dee99qs5aceqhizojivg.jpg"
       },
       publishers: [%{id: 36, name: "Frictional Games"}],
       release_date: ~U[2013-09-10 00:00:00Z],
       short_description:
         "From the creators of Amnesia: The Dark Descent and Dear Esther comes a new first-person horrorgame that will drag you to the depths of greed power and madness. It will bury its snout into your ribs and it will eat your heart."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {4,
     %{
       developers: [%{id: 250, name: "Square"}, %{id: 26, name: "Square Enix"}],
       franchises: [%{id: 4, name: "Final Fantasy"}],
       id: 419,
       name: "Final Fantasy V",
       platforms: [
         %{id: 5, name: "Wii"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 7, name: "PlayStation"},
         %{id: 19, name: "Super Nintendo Entertainment System (SNES)"},
         %{id: 24, name: "Game Boy Advance"}
       ],
       poster: %{
         id: "amjqrxwpqlr0vkmm0dud",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/amjqrxwpqlr0vkmm0dud.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/amjqrxwpqlr0vkmm0dud.jpg"
       },
       publishers: [%{id: 250, name: "Square"}, %{id: 26, name: "Square Enix"}],
       release_date: ~U[1992-12-06 00:00:00Z],
       short_description:
         "Return to the classic medieval tale of magic, monsters and friendship as FINAL FANTASY V comes to PC!"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {42,
     %{
       developers: [%{id: 26, name: "Square Enix"}, %{id: 1983, name: "tri-Ace"}],
       franchises: [%{id: 4, name: "Final Fantasy"}],
       id: 384,
       name: "Final Fantasy XIII-2",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "luj4kmoqjhpkncce5vb3",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/luj4kmoqjhpkncce5vb3.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/luj4kmoqjhpkncce5vb3.jpg"
       },
       publishers: [%{id: 26, name: "Square Enix"}],
       release_date: ~U[2011-12-15 00:00:00Z],
       short_description:
         "FINAL FANTASY XIII-2 is created with the aim of surpassing the quality of its predecessor in every way, featuring new gameplay systems and cutting-edge visuals and audio. In this game the player has the freedom to choose from a range of possibilities and paths; where their choices affect not only the immediate environment, but even shape time and space!"
     }, %{id: 12, name: "Xbox 360"}},
    {65,
     %{
       developers: [%{id: 928, name: "Supergiant Games"}],
       franchises: [],
       id: 1983,
       name: "Bastion",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"},
         %{id: 14, name: "Mac"},
         %{id: 39, name: "iOS"},
         %{id: 46, name: "PlayStation Vita"},
         %{id: 48, name: "PlayStation 4"},
         %{id: 49, name: "Xbox One"},
         %{id: 130, name: "Nintendo Switch"}
       ],
       poster: %{
         id: "co1qlj",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1qlj.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1qlj.jpg"
       },
       publishers: [%{id: 50, name: "WB Games"}],
       release_date: ~U[2011-07-20 00:00:00Z],
       short_description:
         "A hack-and-slash RPG featuring a reactive narrator, various unlockable weapons, weapon upgrades, practice mini-games and optional difficulty modifiers, set in an imaginary world in the aftermath of an uncertain apocalypse, in which the player embodies a teenager with a troubled past as he and the narrator work together to rebuild the world out of a persisting hub called the Bastion."
     }, %{id: 39, name: "iOS"}},
    {469,
     %{
       developers: [%{id: 111, name: "The Creative Assembly"}],
       franchises: [%{id: 977, name: "Total War"}],
       id: 432,
       name: "Total War: Shogun 2",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 14, name: "Mac"},
         %{id: 92, name: "SteamOS"}
       ],
       poster: %{
         id: "tkvu5wuqmgabvhcrvl7w",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/tkvu5wuqmgabvhcrvl7w.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/tkvu5wuqmgabvhcrvl7w.jpg"
       },
       publishers: [%{id: 112, name: "Sega"}, %{id: 23, name: "Feral Interactive"}],
       release_date: ~U[2011-03-15 00:00:00Z],
       short_description:
         "It is the 16th Century in Japan and where once ruled a unified government now stand many clans, all vying for honour, recognition, control and for conquest. As leader of one of these clans, it is your duty to befriend, betray or destroy utterly those that stand in your way as you strive to unite the warring factions and rise up to rule them all as undisputed Shogun – the battle-proven military leader of Japan. \n \nChoose from one of 9 (10 with Ikko-Ikki dlc) clans, each with their own unique traits and skills and each with their own RPG-style warlord to lead them. Use a mixture of diplomacy, political manoeuvring, province building, research and special agents such as Ninja assassins or Geisha spies to get your enemies exactly where you want them. An intuitive user interface and a lovingly-created, complex and detailed campaign map make it both easy and enjoyable to build and run cities, recruit and move troops and issue commands – both noble and dishonourable, all with the aim of mastering enemy forces and seizing their lands."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {485,
     %{
       developers: [%{id: 100, name: "Nival Interactive"}],
       franchises: [],
       id: 10242,
       name: "Blitzkrieg",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "cjnxrdlkh10rrgrxuie5",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/cjnxrdlkh10rrgrxuie5.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/cjnxrdlkh10rrgrxuie5.jpg"
       },
       publishers: [
         %{id: 157, name: "1C Company"},
         %{id: 145, name: "cdv Software Entertainment"},
         %{id: 3023, name: "Virtual Programming"}
       ],
       release_date: ~U[2003-06-04 00:00:00Z],
       short_description:
         "Blitzkrieg is a real-time tactics computer game based on the events of World War II and is the first title in the Blitzkrieg (video game series). The game allows players to assume the role of commanding officer during the battles of World War II that occurred in Europe and North Africa. Each country has its respective historically correct military units. Similar to the Sudden Strike games Blitzkrieg focuses on battles rather than real-time strategy aspects like base building."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {476,
     %{
       developers: [%{id: 51, name: "Blizzard Entertainment"}],
       franchises: [%{id: 135, name: "Warcraft"}],
       id: 123,
       name: "World of Warcraft",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "co1mxb",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mxb.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mxb.jpg"
       },
       publishers: [%{id: 51, name: "Blizzard Entertainment"}],
       release_date: ~U[2004-11-23 00:00:00Z],
       short_description:
         "Four years have passed since the aftermath of Warcraft III: Reign of Chaos, and a great tension now smolders throughout the ravaged world of Azeroth. As the battle-worn races begin to rebuild their shattered kingdoms, new threats, both ancient and ominous, arise to plague the world once again. World of Warcraft is an online role-playing experience set in the award-winning Warcraft universe. Players assume the roles of Warcraft heroes as they explore, adventure, and quest across a vast world. Being \"Massively Multiplayer,\" World of Warcraft allows thousands of players to interact within the same world. Whether adventuring together or fighting against each other in epic battles, players will form friendships, forge alliances, and compete with enemies for power and glory. A dedicated live team will create a constant stream of new adventures to undertake, lands to explore, and monsters to vanquish. This content ensures that the game will never be the same from month to month, and will continue to offer new challenges and adventures for years to come. \n \nThis game has a monthly online fee. Adventure together with thousands of other players simultaneously. Explore an expansive world with miles of forests, deserts, snow-blown mountains, and other exotic lands. Join the Horde or the Alliance as one of 8 playable races. Select from 9 classes, including holy Paladins, shape-shifting Druids, powerful Warriors and Mages, demon-summoning Warlocks, and more. Encounter many familiar and new Warcraft characters and monsters. Learn the continuing story of Azeroth by completing a wide variety of challenging quests. Journey through an epic world filled with dungeons of different styles and depths. Explore 6 huge capital cities, which serve as major hubs for the races inhabiting them. Practice various trade skills to help locate reagents, make and enhance custom items, acquire wealth through trade with other players, and more. Purchase tickets for travel along a number of air routes flown by creatures such as Gryphons and Wyverns. For global transportation, travel by Boat or Goblin Zeppelin. Once a certain level has been achieved, players can choose to purchase permanent personal mounts, such as Dire Wolves and Horses. Establish a guild, purchase a custom guild tabard, and promote or demote recruits to different ranks within the guild. Locate and engage other players with easy-to-use features and tools, including chat channels, friends lists, and animated and audible character expressions. Customize the game's interface via XML. Enjoy hundreds of hours of gameplay with new quests, items, and adventures every month."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {484,
     %{
       developers: [%{id: 377, name: "Firaxis Games"}, %{id: 378, name: "Westlake Interactive"}],
       franchises: [%{id: 10, name: "Sid Meier"}],
       id: 310,
       name: "Sid Meier's Civilization III",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "nhm4swbzgxicb7cfqvwf",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/nhm4swbzgxicb7cfqvwf.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/nhm4swbzgxicb7cfqvwf.jpg"
       },
       publishers: [%{id: 213, name: "Infogrames"}, %{id: 130, name: "MacSoft Games"}],
       release_date: ~U[2001-10-30 00:00:00Z],
       short_description:
         "Civilization III, like the other Civilization games, is based around building an empire, from the ground up, beginning at start of recorded history and continuing beyond the current modern day. The player's civilization is centered around a core of cities that provide the resources necessary to grow the player's cities, construct city improvements, wonders, and units, and advance the player's technological development. The player must balance a good infrastructure, resources, diplomatic and trading skills, technological advancement, city and empire management, culture, and military power to succeed."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {493,
     %{
       developers: [%{id: 1056, name: "Piranha Bytes"}],
       franchises: [],
       id: 2262,
       name: "Gothic II",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "kmknzjrx7dcngzgn6kva",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/kmknzjrx7dcngzgn6kva.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/kmknzjrx7dcngzgn6kva.jpg"
       },
       publishers: [
         %{id: 82, name: "Atari"},
         %{id: 469, name: "JoWooD Entertainment AG"},
         %{id: 753, name: "Nordic Games Publishing"}
       ],
       release_date: ~U[2002-11-29 00:00:00Z],
       short_description:
         "Gothic II is a role-playing video game and the sequel to Gothic, by the German developer Piranha Bytes. It was first released on November 29, 2002 in Germany, with North America following almost one year later on October 28, 2003. The game was published by JoWooD Entertainment and Atari."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {498,
     %{
       developers: [
         %{id: 367, name: "Gray Matter Interactive"},
         %{id: 221, name: "Splash Damage"},
         %{id: 358, name: "Raster Productions"},
         %{id: 187, name: "Nerve Software, LLC"},
         %{id: 378, name: "Westlake Interactive"}
       ],
       franchises: [],
       id: 281,
       name: "Return to Castle Wolfenstein",
       platforms: [
         %{id: 3, name: "Linux"},
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 8, name: "PlayStation 2"},
         %{id: 11, name: "Xbox"},
         %{id: 14, name: "Mac"}
       ],
       poster: %{
         id: "co1pwk",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1pwk.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1pwk.jpg"
       },
       publishers: [
         %{id: 73, name: "Aspyr Media"},
         %{id: 66, name: "Activision"},
         %{id: 184, name: "id Software"},
         %{id: 53, name: "Microsoft Game Studios"}
       ],
       release_date: ~U[2001-11-19 00:00:00Z],
       short_description:
         "World War II rages and nations fall. SS head Himmler has Hitler's full backing to twist science and the occult into an army capable of annihilating the Allies once and for all. Battling alone, you're on an intense mission to pierce the black heart of the Third Reich and stop Himmler -- or die trying. Fighting in advanced team-based multiplayer mode, you'll wage your own WWII in an all-out Axis vs. Allies contest for frontline domination.\n\t\t\t\t\tPowered by the Quake III Arena engine, the Wolfenstein universe explodes with the kind of epic environments, A.I., firepower and cinematic effects that only a game created by true masters can deliver. The dark reich's closing in. The time to act is now. Evil prevails when good men do nothing. \n\t\t\t\t\tEpic Environments\n\t\t\t\t\tIntense Story-Driven Action\n\t\t\t\t\tFerocious A.I.\n\t\t\t\t\tBig Screen Cinematic Effects\n\t\t\t\t\tTeam-Based Multiplayer Action"
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {507,
     %{
       developers: [%{id: 575, name: "Impressions Games"}],
       franchises: [],
       id: 6332,
       name: "Caesar III",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}],
       poster: %{
         id: "kmbq5bvaxtzabcihodfv",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/kmbq5bvaxtzabcihodfv.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/kmbq5bvaxtzabcihodfv.jpg"
       },
       publishers: [%{id: 24, name: "Sierra Entertainment"}],
       release_date: ~U[1998-10-01 00:00:00Z],
       short_description:
         "Caesar III is part of Sierra's City Building Series and was released in October 1998. Cities in Caesar III try to accurately reflect the life of Roman citizens: the lowest plebians live in tents and shacks, while the richest patricians live in villas. Staple foods include wheat, fruits, vegetables, and pork, and wine is required for some festivals and houses. Citizens wander the streets in their various garbs and can tell the player their name and how they feel about the city. The city is viewed in a two dimensional isometric view with a fixed magnification level, and can be rotated ninety degrees.\nAccess to services such as market goods, entertainment, hygiene, education, and taxation are represented by \"walkers,\" which are people sent out from their buildings to patrol the streets. Any house that is passed by a walker is considered to have access to the services of the walker's building. All movements of goods and coverage of walkers are accurately reflected by citizens walking the streets: a player can watch a farm's crop progress, and when it's ready a worker will push a full cart from the farm to a nearby warehouse or granary; then return with an empty cart.\nBackground music is played which varies according to the situation (gentle themes to begin with, war drums during times of conflict and triumphal music when the player nears the objective). Musical themes are supplemented by crowd noises, the sounds of manufacturing and the clash of weapons at appropriate times.\nThere are two ways to play the game: Mission Mode, which is tantamount to typical \"campaign\" modes of other strategy games, and City Construction Mode, in which the player plays one scenario from scratch."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {14,
     %{
       developers: [%{id: 401, name: "Naughty Dog"}],
       franchises: [],
       id: 7331,
       name: "Uncharted 4: A Thief's End",
       platforms: [%{id: 48, name: "PlayStation 4"}],
       poster: %{
         id: "co1r7h",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1r7h.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1r7h.jpg"
       },
       publishers: [%{id: 45, name: "Sony Computer Entertainment, Inc. (SCEI)"}],
       release_date: ~U[2016-05-10 00:00:00Z],
       short_description:
         "Several years after his last adventure, retired fortune hunter, Nathan Drake, is forced back into the world of thieves. With the stakes much more personal, Drake embarks on a globe-trotting journey in pursuit of a historical conspiracy behind a fabled pirate treasure. His greatest adventure will test his physical limits, his resolve, and ultimately what he's willing to sacrifice to save the ones he loves."
     }, %{id: 48, name: "PlayStation 4"}},
    {516,
     %{
       developers: [%{id: 277, name: "EA Canada"}],
       franchises: [],
       id: 91,
       name: "Need for Speed II",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 7, name: "PlayStation"}],
       poster: %{
         id: "co1p80",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1p80.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1p80.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[1997-03-31 00:00:00Z],
       short_description:
         "There are three main game types. The first two are single race and tournament and the last is a knockout race. Single races allow players to become familiar with the circuits and increase their skill of any one of the six tracks. The six tracks are called Mediterranean, Mystic Peaks, Proving Grounds, Outback, North Country, and Pacific Spirit."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {406,
     %{
       developers: [%{id: 7902, name: "Nintendo EPD"}],
       franchises: [%{id: 24, name: "Mario Bros."}],
       id: 26764,
       name: "Mario Kart 8 Deluxe",
       platforms: [%{id: 130, name: "Nintendo Switch"}],
       poster: %{
         id: "co1hxl",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1hxl.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1hxl.jpg"
       },
       publishers: [
         %{id: 2850, name: "Nintendo of America"},
         %{id: 4034, name: "Nintendo of Europe"},
         %{id: 70, name: "Nintendo"}
       ],
       release_date: ~U[2017-04-28 00:00:00Z],
       short_description:
         "\"Hit the road with the definitive version of Mario Kart 8 and play anytime, anywhere! Race your friends or battle them in a revised battle mode on new and returning battle courses. Play locally in up to 4-player multiplayer in 1080p while playing in TV Mode. Every track from the Wii U version, including DLC, makes a glorious return. Plus, the Inklings appear as all-new guest characters, along with returning favorites, such as King Boo, Dry Bones, and Bowser Jr.! \""
     }, %{id: 130, name: "Nintendo Switch"}},
    {525,
     %{
       developers: [%{id: 51, name: "Blizzard Entertainment"}],
       franchises: [],
       id: 230,
       name: "StarCraft",
       platforms: [%{id: 6, name: "PC (Microsoft Windows)"}, %{id: 14, name: "Mac"}],
       poster: %{
         id: "hkpgcjtvdtjb06ik8fse",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/hkpgcjtvdtjb06ik8fse.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/hkpgcjtvdtjb06ik8fse.jpg"
       },
       publishers: [%{id: 51, name: "Blizzard Entertainment"}],
       release_date: ~U[1998-03-31 00:00:00Z],
       short_description:
         "StarCraft is a strategic game set in a Galaxy far away on multiple planets. It's style and balance between the three antagonistic species it features is unique and appealed to millions."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {9,
     %{
       developers: [%{id: 2, name: "BioWare"}, %{id: 222, name: "BioWare Edmonton"}],
       franchises: [],
       id: 74,
       name: "Mass Effect 2",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 9, name: "PlayStation 3"},
         %{id: 12, name: "Xbox 360"}
       ],
       poster: %{
         id: "q8shkfzxblrn22o9dvra",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/q8shkfzxblrn22o9dvra.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/q8shkfzxblrn22o9dvra.jpg"
       },
       publishers: [%{id: 1, name: "Electronic Arts"}],
       release_date: ~U[2010-01-26 00:00:00Z],
       short_description:
         "Are you prepared to lose everything to save the galaxy? You'll need to be, Commander Shephard. It's time to bring together your greatest allies and recruit the galaxy's fighting elite to continue the resistance against the invading Reapers. So steel yourself, because this is an astronomical mission where sacrifices must be made. You'll face tougher choices and new, deadlier enemies. Arm yourself and prepare for an unforgettable intergalactic adventure. \n \nGame Features: \n \nShift the fight in your favour. Equip yourself with powerful new weapons almost instantly thanks to a new inventory system. Plus, an improved health regeneration system means you'll spend less time hunting for restorative items. \n \nMake every decision matter. Divisive crew members are just the tip of the iceberg, Commander, because you'll also be tasked with issues of intergalactic diplomacy. And time's a wastin' so don't be afraid to use new prompt-based actions that let you interrupt conversations, even if they could alter the fate of your crew...and the galaxy. \n \nForge new alliances, carefully. You'll fight alongside some of your most trustworthy crew members, but you'll also get the opportunity to recruit new talent. Just choose your new partners with care because the fate of the galaxy rests on your shoulders, Commander."
     }, %{id: 6, name: "PC (Microsoft Windows)"}},
    {550,
     %{
       developers: [%{id: 113, name: "Westwood Studios"}],
       franchises: [%{id: 136, name: "Frank Herbert's Dune"}],
       id: 86,
       name: "Dune II: The Building of a Dynasty",
       platforms: [
         %{id: 13, name: "PC DOS"},
         %{id: 16, name: "Amiga"},
         %{id: 29, name: "Sega Mega Drive/Genesis"},
         %{id: 116, name: "Acorn Archimedes"}
       ],
       poster: %{
         id: "kuoz0yboghftuc0ybruu",
         medium_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/kuoz0yboghftuc0ybruu.jpg",
         thumb_url:
           "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/kuoz0yboghftuc0ybruu.jpg"
       },
       publishers: [%{id: 141, name: "Virgin Interactive Entertainment (Europe) Ltd."}],
       release_date: ~U[1992-12-01 00:00:00Z],
       short_description:
         "Dune II is often considered the first mainstream modern real-time strategy game and established many conventions of the genre. Even though set in Frank Herbert's famous Dune universe, the game is only loosely connected to the plot of any of the books or the films based from them. Controlling either of the three Houses, the player must fight a number of battles against the other Houses. In the early levels, the goal is simply to earn a certain number of credits, while in the later missions, all enemies must be destroyed. \n \nThe single resource in the game is the Spice, which must be collected by harvesters. The spice is converted to credits in a refinery, which are then spent to construct additional buildings and units. There are two terrain types: buildings can only be constructed on stone, while the Spice is only found on sand. However, units moving on sand attract the large sandworms of Dune, who are virtually indestructible and can swallow even large units whole. As levels progress, new and more advanced buildings and units are made available, including structures like a radar station, a repair facility or defense turrets and, for units, various ground troops, light vehicles and tanks. Each House can construct one unique special unit, and, after building a palace improvement, can unleash a unique palace effect."
     }, %{id: 13, name: "PC DOS"}},
    {543,
     %{
       developers: [%{id: 184, name: "id Software"}],
       franchises: [],
       id: 312,
       name: "Doom II: Hell on Earth",
       platforms: [
         %{id: 6, name: "PC (Microsoft Windows)"},
         %{id: 13, name: "PC DOS"},
         %{id: 14, name: "Mac"},
         %{id: 24, name: "Game Boy Advance"},
         %{id: 36, name: "Xbox Live Arcade"},
         %{id: 44, name: "Tapwave Zodiac"}
       ],
       poster: %{
         id: "co1mwh",
         medium_url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/co1mwh.jpg",
         thumb_url: "https://images.igdb.com/igdb/image/upload/t_cover_small_2x/co1mwh.jpg"
       },
       publishers: [
         %{id: 184, name: "id Software"},
         %{id: 205, name: "GT Interactive"},
         %{id: 2417, name: "Tapwave"},
         %{id: 66, name: "Activision"},
         %{id: 191, name: "Imagineer"},
         %{id: 28, name: "Bethesda Softworks LLC"},
         %{id: 141, name: "Virgin Interactive Entertainment (Europe) Ltd."}
       ],
       release_date: ~U[1994-09-30 00:00:00Z],
       short_description:
         "Let the Obsession begin. Again. This time, the entire forces of the netherworld have overrun Earth. To save her, you must descend into the stygian depths of Hell itself! Battle mightier, nastier, deadlier demons and monsters. Use more powerful weapons. Survive more mind-blowing explosions and more of the bloodiest, fiercest, most awesome blastfest ever!"
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
      |> Repo.update!()
    end)
  end
end
