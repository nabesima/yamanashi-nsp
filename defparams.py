DEF_STAFF_BOUNDS = {
    "All": {
        "D": {
            "Weekday": {
                "hard_lb": 0.15,
                "soft_lb": 0.25,
                "soft_ub": 0.5,
            },
            "Weekend,Holiday": {
                "hard_lb": 0.05,
                "soft_lb": 0.1,
                "soft_ub": 0.15,
            },
        },
        "LD,SE,SN": {
            "Weekday,Weekend,Holiday": {
                "hard_lb": 0.1,
                "soft_lb": 0.15,
                "soft_ub": 0.17,
            },
        },
        "LM": {
            "Weekday,Weekend,Holiday": {
                "hard_ub": 0.05,
            },
        },
        "LD+LM": {
            "Weekday": {
                "hard_lb": 0.1,
                "soft_ub": 0.2,
            },
            "Weekend,Holiday": {
                "hard_lb": 0.1,
                "soft_ub": 0.15,
            }
        },        
    },
    "Expert": {
        "LD,SE,SN": {
            "Weekday,Weekend,Holiday": {
                "hard_lb": 0.1,
                "soft_lb": 0.2,
                "soft_ub": 0.3,
            },
        },
    },
    "Medium": {
        "LD,SE,SN": {
            "Weekday,Weekend,Holiday": {
                "hard_lb": 0.05,
                "soft_lb": 0.1,
                "soft_ub": 0.2,
            },
        },
    },
    "Novice": {
        "LD,SE,SN": {
            "Weekday,Weekend,Holiday": {
                "soft_lb": 0.2,
                "soft_ub": 0.2,
                "hardt_ub": 0.2,
            },
        },
    },
}
