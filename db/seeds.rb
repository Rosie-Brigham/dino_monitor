# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
SiteGroup.create([
  {
    name: "Irish Elks"
  },
  {
    name: "Giant Sloths"
  },
  {
    name: "Tertiary Mammals"
  },
  {
    name: "Cretaceous Pterosaurs"
  },
  {
    name: "Mosasaur"
  },
  {
    name: "Jurassic Park"
  },
  {
    name: "Iguanadons"
  },
  {
    name: "Jurassic outcrop and Pterosaurs"
  },
  {
    name: "Marine reptiles"
  },
  {
    name: "Triassic tetrapods"
  },
  {
    name: "Mainland geological illustrations"
  },
  {
    name: "Unsorted"
  },
  {
    name: "Not relevant"
  }
])


Site.create([
  {
    name: "Megaloceros female",
    notes: { informal_description: "Irish Elk - female lying down" },
    site_group_id: SiteGroup.find_by(name: "Irish Elks").id
  },
  {
    name: "Megaloceros male A",
    notes: { informal_description: "Irish Elk - lower standing male" },
    site_group_id: SiteGroup.find_by(name: "Irish Elks").id
  },
  {
    name: "Megaloceros male B",
    notes: { informal_description: "Irish Elk - higher standing male" },
    site_group_id: SiteGroup.find_by(name: "Irish Elks").id
  },
  {
    name: "Megaloceros fawn",
    notes: { informal_description: "Irish Elk - sitting fawn" },
    site_group_id: SiteGroup.find_by(name: "Irish Elks").id
  },
  {
    name: "Glacial gravels",
    notes: { informal_description: "geological illustration - bases to Megaloceros (Irish Elk)" },
    site_group_id: SiteGroup.find_by(name: "Irish Elks").id
  },
  {
    name: "Megatherium",
    notes: { informal_description: "giant sloth" },
    site_group_id: SiteGroup.find_by(name: "Giant sloth").id

  },
  {
    name: "Argentinian gravels",
    notes: { informal_description: "geological illustration - flint gravel below the giant sloth"},
    site_group_id: SiteGroup.find_by(name: "Giant sloth").id
  },
  {
    name: "Anoplotherium commune (standing)",
    notes: { informal_description: "camel-like Tertiary mammal - standing"},
    site_group_id: SiteGroup.find_by(name: "Tertiary mammals").id
  },
  {
    name: "Anoplotherium (lying)",
    notes: { informal_description: "camel-like Tertiary mammal - lying down"},
    site_group_id: SiteGroup.find_by(name: "Tertiary mammals").id
  },  
  {
    name: "Anoplotherium commune (rearing)",
    notes: { informal_description: "camel-like Tertiary mammal - standing with rearing head"},
    site_group_id: SiteGroup.find_by(name: "Tertiary mammals").id
  },
  {
    name: "Palaeotherium (standing)",
    notes: { informal_description: "long-nosed Tertiary mammal - standing"},
    site_group_id: SiteGroup.find_by(name: "Tertiary mammals").id
  },
  {
    name: "Palaeotherium (sitting)",
    notes: { informal_description: "long-nosed Tertiary mammal - sitting"},
    site_group_id: SiteGroup.find_by(name: "Tertiary mammals").id
  },
  {
    name: "Palaeotherium 3",
    notes: { informal_description: "Missing - a third Palaeotherium was originally present"},
    site_group_id: SiteGroup.find_by(name: "Tertiary mammals").id
  },
  {
    name: "Cretaceous Pterosaur A",
    notes: { informal_description: "Pterosaur with outstretched wings"},
    site_group_id: SiteGroup.find_by(name: "Cretaceous Pterosaurs").id
  },
  {
    name: "Cretaceous Pterosaur B",
    notes: { informal_description: "Pterosaur with folded wings"},
    site_group_id: SiteGroup.find_by(name: "Cretaceous Pterosaurs").id
  },
  {
    name: "Chalk",
    notes: { informal_description: "geological illustration - Chalk cliff forming base to Pterosaurs" },
    site_group_id: SiteGroup.find_by(name: "Cretaceous Pterosaurs").id
  },
  {
    name: "Mosasaurus",
    notes: { informal_description: "Big marine reptile - by the weir/separate from the others" },
    site_group_id: SiteGroup.find_by(name: "Mosasaur").id
  },
  {
    name: "Iguanodon (standing)",
    notes: { informal_description: "Big dinosaur - standing on rock"},
    site_group_id: SiteGroup.find_by(name: "Iguanodons").id
  },
  {
    name: "Iguanodon (sitting)",
    notes: { informal_description: "Big dinosaur - partially recumbent"},
    site_group_id: SiteGroup.find_by(name: "Iguanodons").id
  },
  {
    name: "Hylaeosaurus",
    notes: { informal_description: "Big spiny dinosaur"},
    site_group_id: SiteGroup.find_by(name: "Hylaeosaurus").id
  },
  {
    name: "Cycads",
    notes: { informal_description: "Cylindrical Cretaceous plants"},
    site_group_id: SiteGroup.find_by(name: "Iguanodons").id
  },
  {
    name: "Wealden",
    notes: { informal_description: "geological illustration - Wealden sandstone around and forming bases to the main dinosaurs"},
    site_group_id: SiteGroup.find_by(name: "Iguanodons").id
  },
  {
    name: "Megalosaurus",
    notes: { informal_description: "Big mean dinosaur - Meg"},
    site_group_id: SiteGroup.find_by(name: "Megalosaurus").id
  },
  {
    name: "Portlandian Oolite",
    notes: { informal_description: "geological illustration -base to the Megalosaurus, includes Portlandian tree from the Lulworth Cove fossil forest"},
    site_group_id: SiteGroup.find_by(name: "Megalosaurus").id
  },
  {
    name: "Jurassic Pterodactyl A",
    notes: { informal_description: "missing Pterosaur (wings open); higher, beak vertical"},
    site_group_id: SiteGroup.find_by(name: "Jurassic outcrop and Pterosaurs").id
  },
  {
    name: "Jurassic Pterodactyl B",
    notes: { informal_description: "missing Pterosaur (wings open);lower, beak at 45°"},
    site_group_id: SiteGroup.find_by(name: "Jurassic outcrop and Pterosaurs").id
  },
  {
    name: "Oolite",
    notes: { informal_description: "geological illustration - yellow Middle Jurassic oolite from the Cotwolds. Was base to the Jurassic pterosaurs"},
    site_group_id: SiteGroup.find_by(name: "Jurassic outcrop and Pterosaurs").id
  },
  {
    name: "Ichthyosaurus communis",
    notes: { informal_description: "SW Ichthyosaur (large head, big eyes) - unpainted, parallel to path"},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Ichthyosaurus tenuirostris",
    notes: { informal_description: "Central Ichthyosaur (large head, big eyes) - painted, facing away from path"},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Ichthyosaurus platyodon",
    notes: { informal_description: "NE Ichthyosaur (large head, big eyes) - painted, facing toward path"},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Plesiosaurus hawkinsii",
    notes: { informal_description: "SW Plesiosaur (long neck & small head) - facing a <i>Labyrinthodon</i>"},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Plesiosaurus dolichoderus",
    notes: { informal_description: "Central Plesiosaur (long neck & small head) - facing away from path"},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Plesiosaurus macrocephalus",
    notes: { informal_description: "NE Plesiosaur (long neck & small head) - facing toward path"},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Teleosaurus A",
    notes: { informal_description: "crocodile - snout horizontal, nearer the Plesiosaurs"},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Teleosaurus B",
    notes: { informal_description: "crocodile - snout raised, nearer the Megalosaur"},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Lias",
    notes: { informal_description: "geological illustration - Lias cliff of alternating shale-limestone couplets. Behind the marine reptiles."},
    site_group_id: SiteGroup.find_by(name: "Marine reptiles").id
  },
  {
    name: "Labyrinthodon pachygnathus A",
    notes: { informal_description: "Primitive amphibian - warty skin, separated from the other two"},
    site_group_id: SiteGroup.find_by(name: "Triassic tetrapods").id
  },
  {
    name: "Labyrinthodon salamandroides",
    notes: { informal_description: "Primitive amphibian - smooth skin"},
    site_group_id: SiteGroup.find_by(name: "Triassic tetrapods").id
  },
  {
    name: "Labyrinthodon pachygnathus B",
    notes: { informal_description: "Primitive amphibian - warty skin, hunched, near the smooth backed <i>Labyrinthodon</i>"},
    site_group_id: SiteGroup.find_by(name: "Triassic tetrapods").id
  },
  {
    name: "Dicynodon (larger)",
    notes: { informal_description: "Turtle-like Triassic amphibian - larger, looking at companion"},
    site_group_id: SiteGroup.find_by(name: "Triassic tetrapods").id
  },
  {
    name: "Dicynodon (smaller)",
    notes: { informal_description: "Turtle-like Triassic amphibian - smaller, looking away from companion"},
    site_group_id: SiteGroup.find_by(name: "Triassic tetrapods").id
  },
  {
    name: "New Red Sandstone",
    notes: { informal_description: "geological illustration - Triassic sandstone cliff dipping beneath the Lias"},
    site_group_id: SiteGroup.find_by(name: "Triassic tetrapods").id
  },
  {
    name: "Coal Measures",
    notes: { informal_description: "geological illustration - cliff of Derbyshire coal measures"},
    site_group_id: SiteGroup.find_by(name: "Mainland geological illustrations").id
  },
  {
    name: "Mountain Limestone cliff",
    notes: { informal_description: "geological illustration - Carboniferous limestone cliff, largely destroyed in 1960s, rebuilt in 2002"},
    site_group_id: SiteGroup.find_by(name: "Mainland geological illustrations").id
  },
  {
    name: "Lead Mine",
    notes: { informal_description: "geological illustration - lead mine, formerly at the base of the Carboniferous limestone cliff"},
    site_group_id: SiteGroup.find_by(name: "Mainland geological illustrations").id
  },
  {
    name: "Old Red Sandstone",
    notes: { informal_description: "geological illustration - Old Red Sanstone"},
    site_group_id: SiteGroup.find_by(name: "Mainland geological illustrations").id
  },
  {
    name: "Lewisian Gneiss",
    notes: { informal_description: "geological illustration - boulder"},
    site_group_id: SiteGroup.find_by(name: "Mainland geological illustrations").id
  },
  {
    name: "Twitter unsorted",
    notes: { informal_description: "Unsorted submissions taken from daily twitter scraper"},
    site_group_id: SiteGroup.find_by(name: "Unsorted").id
  },
  {
    name: "Instagram unsorted",
    notes: { informal_description: "Unsorted images, taken from Instagram scraper"},
    site_group_id: SiteGroup.find_by(name: "Unsorted").id
  },
  {
    name: "Uploaded unsorted",
    notes: { informal_description: "Unsorted submissions uploaded via bulk form"},
    site_group_id: SiteGroup.find_by(name: "Unsorted").id
  },
  {
    name: "Unidentified",
    notes: { informal_description: "Submissions that are not identifiable"},
    site_group_id: SiteGroup.find_by(name: "Not relevant").id
  },
  {
    name: "Unsuitable",
    notes: { informal_description: "Images that are unsuitable"},
    site_group_id: SiteGroup.find_by(name: "Not relevant").id
  },
])

