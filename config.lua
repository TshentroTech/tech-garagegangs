Config = Config or {}

Config.Fuel = 'lc_fuel' --ps-fuel, lj-fuel, LegacyFuel

-- Speed limits for specific vehicles (in km/h)
Config.SpeedLimits = {
    ["zx10r"] = 270,
    ["venatusc"] = 270,
    ["abhawk"] = 270,
    ["tmaxDX"] = 270,
    ["zx6r"] = 270,
    ["ikx3abt20"] = 270,
    ["16charger"] = 270,
    ["africat"] = 270,
}



Config.Gangs = {
    ["sans"] = {
        ["VehicleSpawner"] = vector4(17.64, -1221.76, 29.3, 269.62),
        ["colors"] = { 120, 120 }, -- Light Blue (Sans = "without" - clean, simple)
        ["vehicles"] = {
            ["enduro"] = "enduro",
            ["buccaneer"] = "Buccaneer"
        },
    },
    ["wolves"] = {
        ["VehicleSpawner"] = vector4(721.99, -686.97, 27.11, 356.39),
        ["colors"] = { 156, 156 }, -- Silver/Gray (Wolf pack colors)
        ["vehicles"] = {
            ["enduro"] = "enduro",
            ["buccaneer"] = "Buccaneer"
        },
    },
    ["castro"] = {
        ["VehicleSpawner"] = vector4(175.73, 1690.01, 227.73, 190.69),
        ["colors"] = { 0, 0 }, -- Black (Castro = sleek, powerful)
        ["vehicles"] = {
            ["zx10r"] = "zx10r",---done  CAR FOR CUSTOM GANG 250KMH > 270KMH
            ["venatusc"] = "venatusc"---done CAR FOR CUSTOM GANG 250KMH > 270KMH
        },
    },
    ["hand"] = {
        ["VehicleSpawner"] = vector4(182.13, 2785.71, 46.13, 277.6),
        ["colors"] = { 147, 147 }, -- Dark Red (Hand = blood, power)
        ["vehicles"] = {
            ["enduro"] = "enduro",
            ["buccaneer"] = "Buccaneer"
        },
    },
    ["shadows"] = {
        ["VehicleSpawner"] = vector4(-44.07, 2855.04, 58.42, 169.18),
        ["colors"] = { 0, 0 }, -- Black (Shadows = darkness, stealth)
        ["vehicles"] = {
            ["enduro"] = "enduro",
            ["buccaneer"] = "Buccaneer"
        },
    },
    ["deivils"] = {
        ["VehicleSpawner"] = vector4(1372.06, 1147.32, 113.76, 84.62),
        ["colors"] = { 156, 156 }, -- Grey (Devils = neutral, mysterious)
        ["vehicles"] = {
            ["abhawk"] = "abhawk",--- CAR FOR CUSTOM GANG 250KMH > 270KMH
            ["tmaxDX"] = "tmaxDX"--- CAR FOR CUSTOM GANG 250KMH > 270KMH
        },
    },
    ["westside"] = {
        ["VehicleSpawner"] = vector4(3334.85, 5162.6, 18.3, 149.39),
        ["colors"] = { 111, 111 }, -- White (Westside = clean, pure)
        ["vehicles"] = {
            ["zx10r"] = "zx6r",--- CAR FOR CUSTOM GANG 250KMH > 270KMH
            ["ikx3abt20"] = "ikx3abt20"--- CAR FOR CUSTOM GANG 250KMH > 270KMH
        },
    },
    ["reapers"] = {
        ["VehicleSpawner"] = vector4(377.08, -1817.64, 29.16, 50.34),
        ["colors"] = { 0, 0 }, -- Black (Reapers = death, darkness)
        ["vehicles"] = {
            ["enduro"] = "enduro",
            ["buccaneer"] = "Buccaneer"
        },
    },
    ["venom"] = {
        ["VehicleSpawner"] = vector4(2195.57, 5603.54, 53.55, 320.58),
        ["colors"] = { 92, 92 }, -- Lime Green (Venom = poison, toxic)
        ["vehicles"] = {
            ["enduro"] = "enduro",
            ["buccaneer"] = "Buccaneer"
        },
    },
    ["baby"] = {
        ["VehicleSpawner"] = vector4(-2197.22, 4257.8, 47.99, 28.56),
        ["colors"] = { 120, 120 }, -- Blue (Baby = calm, peaceful)
        ["vehicles"] = {
            ["16charger"] = "16charger",--- CAR FOR CUSTOM GANG 250KMH > 270KMH
            ["africat"] = "africat"--- CAR FOR CUSTOM GANG 250KMH > 270KMH
        },
    },
    ["silent"] = {
        ["VehicleSpawner"] = vector4(107.64, -1942.69, 20.8, 44.63),
        ["colors"] = { 156, 156 }, -- Silver (Silent = stealth, subtle)
        ["vehicles"] = {
            ["enduro"] = "enduro",
            ["buccaneer"] = "Buccaneer"
        },
    }
}
