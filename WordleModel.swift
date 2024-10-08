import SwiftUI

class WordleModel : ObservableObject {
    @Published var guesses : [Guess] = []
    @Published var incorrectAttemps = [Int](repeating: 0, count: 6)
    @Published var alertType:AlertType = .none
    @Published var gameResultMessage = ""
    @Published var wrongTime = 0
    @Published var rightTime: [Int] = [0, 0, 0, 0, 0, 0]
    let wordChoices : [String] = [
        "ABACK", "ABASE", "ABATE", "ABBEY", "ABIDE", "ABOUT", "ABOVE", "ABYSS", "ACORN", "ACRID",
        "ACTOR", "ACUTE", "ADAGE", "ADAPT", "ADMIT", "ADOBE", "ADOPT", "ADORE", "ADULT", "AFTER",
        "AGAIN", "AGAPE", "AGATE", "AGENT", "AGILE", "AGING", "AGLOW", "AGONY", "AGREE", "AHEAD",
        "AISLE", "ALBUM", "ALIEN", "ALIKE", "ALIVE", "ALLOW", "ALOFT", "ALONE", "ALOOF", "ALOUD",
        "ALPHA", "ALTAR", "ALTER", "AMASS", "AMBER", "AMISS", "AMPLE", "ANGEL", "ANGER", "ANGRY",
        "ANGST", "ANODE", "ANTIC", "ANVIL", "AORTA", "APART", "APHID", "APPLE", "APPLY", "APRON",
        "APTLY", "ARBOR", "ARDOR", "ARGUE", "AROMA", "ASCOT", "ASIDE", "ASKEW", "ASSET", "ATOLL",
        "ATONE", "AUDIO", "AUDIT", "AVAIL", "AVERT", "AWAIT", "AWAKE", "AWASH", "AWFUL", "AXIOM",
        "AZURE", "BACON", "BADGE", "BADLY", "BAGEL", "BAKER", "BALSA", "BANAL", "BARGE", "BASIC",
        "BASIN", "BATHE", "BATON", "BATTY", "BAYOU", "BEACH", "BEADY", "BEAST", "BEAUT", "BEEFY",
        "BEGET", "BEGIN", "BEING", "BELCH", "BELIE", "BELLY", "BELOW", "BENCH", "BERET", "BERTH",
        "BESET", "BEVEL", "BINGE", "BIOME", "BIRCH", "BIRTH", "BLACK", "BLAME", "BLAND", "BLARE",
        "BLEAK", "BLEED", "BLEEP", "BLIMP", "BLOCK", "BLOKE", "BLOND", "BLOWN", "BLUFF", "BLURB",
        "BLURT", "BLUSH", "BOOBY", "BOOST", "BOOZE", "BOOZY", "BORAX", "BOUGH", "BRACE", "BRAID",
        "BRAIN", "BRAKE", "BRASH", "BRASS", "BRAVE", "BRAVO", "BREAD", "BREAK", "BREED", "BRIAR",
        "BRIBE", "BRIDE", "BRIEF", "BRINE", "BRING", "BRINK", "BRINY", "BRISK", "BROAD", "BROKE",
        "BROOK", "BROOM", "BROTH", "BRUSH", "BRUTE", "BUDDY", "BUGGY", "BUGLE", "BUILD", "BUILT",
        "BULKY", "BULLY", "BUNCH", "BURLY", "CABLE", "CACAO", "CACHE", "CADET", "CAMEL", "CAMEO",
        "CANDY", "CANNY", "CANOE", "CANON", "CAPER", "CARAT", "CARGO", "CAROL", "CARRY", "CATCH",
        "CATER", "CAULK", "CAUSE", "CEDAR", "CHAFE", "CHAIN", "CHALK", "CHAMP", "CHANT", "CHAOS",
        "CHARD", "CHARM", "CHART", "CHEAT", "CHEEK", "CHEER", "CHEST", "CHIEF", "CHILD", "CHILL",
        "CHIME", "CHOIR", "CHOKE", "CHORD", "CHUNK", "CHUTE", "CIDER", "CIGAR", "CINCH", "CIRCA",
        "CIVIC", "CLASS", "CLEAN", "CLEAR", "CLEFT", "CLERK", "CLICK", "CLIMB", "CLING", "CLOCK",
        "CLONE", "CLOSE", "CLOTH", "CLOUD", "CLOWN", "CLUCK", "COACH", "COAST", "COCOA", "COLON",
        "COMET", "COMMA", "CONDO", "CONIC", "CORNY", "COULD", "COUNT", "COURT", "COVER", "COVET",
        "COWER", "COYLY", "CRAFT", "CRAMP", "CRANE", "CRANK", "CRASS", "CRATE", "CRAVE", "CRAZE",
        "CRAZY", "CREAK", "CREDO", "CREPT", "CRIME", "CRIMP", "CROAK", "CRONE", "CROSS", "CROWD",
        "CROWN", "CRUMB", "CRUSH", "CRUST", "CUMIN", "CURLY", "CYNIC", "DADDY", "DAISY", "DANCE",
        "DANDY", "DEATH", "DEBIT", "DEBUG", "DEBUT", "DECAL", "DECAY", "DECOY", "DELAY", "DELTA",
        "DELVE", "DENIM", "DEPOT", "DEPTH", "DETER", "DEVIL", "DIARY", "DIGIT", "DINER", "DINGO",
        "DISCO", "DITTO", "DODGE", "DOING", "DOLLY", "DONOR", "DONUT", "DOUBT", "DOWRY", "DOZEN",
        "DRAIN", "DRAWN", "DREAM", "DRINK", "DRIVE", "DROLL", "DROOP", "DROVE", "DUCHY", "DUTCH",
        "DUVET", "DWARF", "DWELL", "DWELT", "EARLY", "EARTH", "EBONY", "EDICT", "EGRET", "EJECT",
        "ELDER", "ELOPE", "ELUDE", "EMAIL", "EMBER", "EMPTY", "ENACT", "ENEMA", "ENJOY", "ENNUI",
        "ENSUE", "ENTER", "EPOCH", "EPOXY", "EQUAL", "EQUIP", "ERODE", "ERROR", "ERUPT", "ESSAY",
        "ETHER", "ETHIC", "ETHOS", "EVADE", "EVERY", "EVOKE", "EXACT", "EXALT", "EXCEL", "EXERT",
        "EXIST", "EXPEL", "EXTRA", "EXULT", "FACET", "FAINT", "FAITH", "FARCE", "FAULT", "FAVOR",
        "FEAST", "FEIGN", "FERAL", "FERRY", "FEWER", "FIELD", "FIEND", "FIFTY", "FILET", "FINAL",
        "FINCH", "FINER", "FIRST", "FISHY", "FIXER", "FJORD", "FLAIL", "FLAIR", "FLAKE", "FLAME",
        "FLANK", "FLARE", "FLASK", "FLESH", "FLICK", "FLING", "FLIRT", "FLOAT", "FLOCK", "FLOOD",
        "FLOOR", "FLORA", "FLOSS", "FLOUR", "FLOUT", "FLUFF", "FLUME", "FLUNK", "FLYER", "FOCAL",
        "FOCUS", "FOGGY", "FOLLY", "FORAY", "FORCE", "FORGE", "FORGO", "FORTE", "FORTH", "FORTY",
        "FOUND", "FOYER", "FRAME", "FRANK", "FRESH", "FRIED", "FROCK", "FROND", "FRONT", "FROST",
        "FROTH", "FROZE", "FULLY", "FUNGI", "FUNNY", "GAMER", "GAMMA", "GAUDY", "GAUNT", "GAUZE",
        "GAWKY", "GECKO", "GENRE", "GHOUL", "GIANT", "GIDDY", "GIRTH", "GIVEN", "GLASS", "GLAZE",
        "GLEAM", "GLEAN", "GLIDE", "GLOAT", "GLOBE", "GLOOM", "GLORY", "GLOVE", "GLYPH", "GNASH",
        "GOLEM", "GONER", "GOOSE", "GORGE", "GOUGE", "GRACE", "GRADE", "GRAIL", "GRAND", "GRAPH",
        "GRASP", "GRATE", "GREAT", "GREEN", "GREET", "GRIEF", "GRIME", "GRIMY", "GRIND", "GRIPE",
        "GROIN", "GROOM", "GROUP", "GROUT", "GROVE", "GROWL", "GRUEL", "GUANO", "GUARD", "GUEST",
        "GUIDE", "GUILD", "GULLY", "GUMMY", "GUPPY", "HAIRY", "HANDY", "HAPPY", "HARSH", "HATCH",
        "HATER", "HAVOC", "HEADY", "HEARD", "HEART", "HEATH", "HEAVE", "HEAVY", "HEIST", "HELIX",
        "HELLO", "HENCE", "HERON", "HINGE", "HITCH", "HOARD", "HOBBY", "HOMER", "HONEY", "HORDE",
        "HORSE", "HOTEL", "HOUND", "HOUSE", "HOWDY", "HUMAN", "HUMID", "HUMOR", "HUMPH", "HUNCH",
        "HUNKY", "HURRY", "HUTCH", "HYPER", "IGLOO", "IMAGE", "IMPEL", "INANE", "INDEX", "INEPT",
        "INERT", "INFER", "INLAY", "INPUT", "INTER", "INTRO", "IONIC", "IRATE", "IRONY", "ISLET",
        "ITCHY", "IVORY", "JAUNT", "JAZZY", "JERKY", "JIFFY", "JOKER", "JOLLY", "JOUST", "JUDGE",
        "JUICE", "KARMA", "KAYAK", "KAZOO", "KEBAB", "KHAKI", "KIOSK", "KNAVE", "KNEAD", "KNEEL",
        "KNELT", "KNOCK", "KNOLL", "KOALA", "LABEL", "LABOR", "LAGER", "LANKY", "LAPEL", "LAPSE",
        "LARGE", "LARVA", "LASER", "LATTE", "LAYER", "LEAFY", "LEAKY", "LEAPT", "LEARN", "LEASH",
        "LEAVE", "LEDGE", "LEECH", "LEERY", "LEGGY", "LEMON", "LIBEL", "LIGHT", "LILAC", "LIMIT",
        "LINEN", "LINER", "LINGO", "LITHE", "LIVER", "LOCAL", "LOCUS", "LOFTY", "LOGIC", "LOOPY",
        "LOSER", "LOUSE", "LOVER", "LOWER", "LOWLY", "LOYAL", "LUCID", "LUCKY", "LUNAR", "LUNCH",
        "LUNGE", "LUSTY", "LYING", "MACAW", "MADAM", "MAGIC", "MAGMA", "MAIZE", "MAJOR", "MANIA",
        "MANGA", "MANLY", "MANOR", "MAPLE", "MARCH", "MARRY", "MARSH", "MASON", "MASSE", "MATCH",
        "MATEY", "MAXIM", "MAYBE", "MAYOR", "MEALY", "MEANT", "MEDAL", "MEDIA", "MEDIC", "MELON",
        "MERCY", "MERGE", "MERIT", "MERRY", "METAL", "METER", "METRO", "MICRO", "MIDGE", "MIDST",
        "MIMIC", "MINCE", "MINER", "MINUS", "MODEL", "MODEM", "MOIST", "MOLAR", "MONEY", "MONTH",
        "MOOSE", "MOSSY", "MOTOR", "MOTTO", "MOULT", "MOUNT", "MOURN", "MOUSE", "MOVIE", "MUCKY",
        "MULCH", "MUMMY", "MURAL", "MUSHY", "MUSIC", "MUSTY", "NAIVE", "NANNY", "NASTY", "NATAL",
        "NAVAL", "NEEDY", "NEIGH", "NERDY", "NEVER", "NICER", "NIGHT", "NINJA", "NINTH", "NOBLE",
        "NOISE", "NORTH", "NYMPH", "OCCUR", "OCEAN", "OFFAL", "OFTEN", "OLDER", "OLIVE", "ONION",
        "ONSET", "OPERA", "ORDER", "ORGAN", "OTHER", "OUGHT", "OUNCE", "OUTDO", "OUTER", "OVERT",
        "OWNER", "OXIDE", "PAINT", "PANEL", "PANIC", "PAPAL", "PAPER", "PARER", "PARRY", "PARTY",
        "PASTA", "PATTY", "PAUSE", "PEACE", "PEACH", "PENNE", "PERCH", "PERKY", "PESKY", "PHASE",
        "PHONE", "PHONY", "PHOTO", "PIANO", "PICKY", "PIETY", "PILOT", "PINCH", "PINEY", "PINKY",
        "PINTO", "PIOUS", "PIPER", "PIQUE", "PITHY", "PIXEL", "PIXIE", "PLACE", "PLAIT", "PLANK",
        "PLANT", "PLATE", "PLAZA", "PLEAT", "PLUCK", "PLUNK", "POINT", "POISE", "POKER", "POLKA",
        "POLYP", "PORCH", "POUND", "POWER", "PRESS", "PRICE", "PRICK", "PRIDE", "PRIME", "PRIMO",
        "PRINT", "PRIOR", "PRIZE", "PROBE", "PRONG", "PROUD", "PROVE", "PROWL", "PROXY", "PRUNE",
        "PSALM", "PULPY", "PURGE", "QUALM", "QUART", "QUEEN", "QUERY", "QUEST", "QUEUE", "QUICK",
        "QUIET", "QUIRK", "QUITE", "QUOTE", "RADIO", "RAINY", "RAISE", "RAMEN", "RANCH", "RANGE",
        "RATIO", "RAYON", "REACT", "REALM", "REBEL", "REBUS", "REBUT", "RECAP", "RECUR", "REFER",
        "REGAL", "RELIC", "RENEW", "REPAY", "REPEL", "RERUN", "RESIN", "RETCH", "RETRO", "RETRY",
        "REVEL", "RHINO", "RHYME", "RIDGE", "RIDER", "RIGHT", "RIPER", "RISEN", "RIVAL", "ROBIN",
        "ROBOT", "ROCKY", "RODEO", "ROGUE", "ROOMY", "ROUGE", "ROUND", "ROUSE", "ROUTE", "ROVER",
        "ROYAL", "RUDDY", "RUDER", "RUPEE", "RUSTY", "SAINT", "SALAD", "SALLY", "SALSA", "SALTY",
        "SASSY", "SAUCY", "SAUTE", "SAVOR", "SCALD", "SCALE", "SCANT", "SCARE", "SCARF", "SCENT",
        "SCOFF", "SCOLD", "SCONE", "SCOPE", "SCORN", "SCOUR", "SCOUT", "SCRAM", "SCRAP", "SCRUB",
        "SEDAN", "SEEDY", "SENSE", "SERUM", "SERVE", "SEVEN", "SEVER", "SHADE", "SHAFT", "SHAKE",
        "SHALL", "SHAME", "SHANK", "SHAPE", "SHARD", "SHARP", "SHAVE", "SHAWL", "SHELL", "SHIFT",
        "SHINE", "SHIRE", "SHIRK", "SHORE", "SHORN", "SHOWN", "SHOWY", "SHRUB", "SHRUG", "SHYLY",
        "SIEGE", "SIGHT", "SINCE", "SISSY", "SKATE", "SKIER", "SKIFF", "SKILL", "SKIMP", "SKIRT",
        "SKUNK", "SLATE", "SLEEK", "SLEEP", "SLICE", "SLOPE", "SLOSH", "SLOTH", "SLUMP", "SLUNG",
        "SMALL", "SMART", "SMASH", "SMEAR", "SMELT", "SMILE", "SMIRK", "SMITE", "SMITH", "SMOCK",
        "SMOKE", "SNACK", "SNAFU", "SNAIL", "SNAKE", "SNAKY", "SNARE", "SNARL", "SNEAK", "SNORT",
        "SNOUT", "SOGGY", "SOLAR", "SOLID", "SOLVE", "SONIC", "SOUND", "SOWER", "SPACE", "SPADE",
        "SPEAK", "SPECK", "SPELL", "SPELT", "SPEND", "SPENT", "SPICE", "SPICY", "SPIEL", "SPIKE",
        "SPILL", "SPIRE", "SPLAT", "SPOKE", "SPOUT", "SPRAY", "SPURT", "SQUAD", "SQUAT", "STAFF",
        "STAGE", "STAID", "STAIR", "STAKE", "STALE", "STALL", "STAND", "STARK", "START", "STASH",
        "STATE", "STEAD", "STEAM", "STEED", "STEEL", "STEIN", "STERN", "STICK", "STIFF", "STILL",
        "STING", "STINK", "STOCK", "STOLE", "STOMP", "STONE", "STONY", "STOOL", "STORE", "STORM",
        "STORY", "STOUT", "STOVE", "STRAP", "STRAW", "STUDY", "STUNG", "STYLE", "SUGAR", "SULKY",
        "SUPER", "SURER", "SURLY", "SUSHI", "SWEAT", "SWEEP", "SWEET", "SWILL", "SWINE", "SWIRL",
        "SWISH", "SWOON", "SWUNG", "SYRUP", "TABLE", "TABOO", "TACIT", "TAKEN", "TALON", "TANGY",
        "TAPER", "TAPIR", "TARDY", "TASTE", "TASTY", "TAUNT", "TAWNY", "TEACH", "TEARY", "TEASE",
        "TEMPO", "TENTH", "TEPID", "TERSE", "THANK", "THEIR", "THEME", "THERE", "THESE", "THIEF",
        "THIGH", "THING", "THINK", "THIRD", "THORN", "THOSE", "THREE", "THREW", "THROW", "THUMB",
        "THUMP", "THYME", "TIARA", "TIBIA", "TIDAL", "TIGER", "TILDE", "TIPSY", "TITAN", "TITHE",
        "TITLE", "TODAY", "TONIC", "TOPAZ", "TOPIC", "TORCH", "TORSO", "TOTEM", "TOUCH", "TOUGH",
        "TOWEL", "TOXIC", "TOXIN", "TRACE", "TRACT", "TRADE", "TRAIN", "TRAIT", "TRASH", "TRAWL",
        "TREAT", "TREND", "TRIAD", "TRICE", "TRITE", "TROLL", "TROPE", "TROVE", "TRUSS", "TRUST",
        "TRUTH", "TRYST", "TUTOR", "TWANG", "TWEAK", "TWEED", "TWICE", "TWINE", "TWIRL", "ULCER",
        "ULTRA", "UNCLE", "UNDER", "UNDUE", "UNFED", "UNFIT", "UNIFY", "UNITE", "UNLIT", "UNMET",
        "UNTIE", "UNTIL", "UNZIP", "UPSET", "URBAN", "USAGE", "USHER", "USING", "USUAL", "USURP",
        "UTTER", "VAGUE", "VALET", "VALID", "VALUE", "VAPID", "VAULT", "VENOM", "VERGE", "VERVE",
        "VIDEO", "VIGOR", "VIOLA", "VIRAL", "VITAL", "VIVID", "VODKA", "VOICE", "VOILA", "VOTER",
        "VOUCH", "WACKY", "WAGON", "WALTZ", "WASTE", "WATCH", "WEARY", "WEDGE", "WHACK", "WHALE",
        "WHEEL", "WHELP", "WHERE", "WHICH", "WHIFF", "WHILE", "WHINE", "WHINY", "WHIRL", "WHISK",
        "WHOOP", "WIDEN", "WINCE", "WINDY", "WOKEN", "WOMAN", "WOOER", "WORDY", "WORLD", "WORRY",
        "WORSE", "WORST", "WOULD", "WOVEN", "WRATH", "WRIST", "WRITE", "WRONG", "WROTE", "WRUNG",
        "YACHT", "YEARN", "YIELD", "YOUNG", "YOUTH", "ZEBRA", "ZESTY"
    ]
    var keyColours = [String : Color] ()
    var matchedLetter = [String]()
    var misplacedLetters = [String]()
    var selectedWord = ""
    var currentWord = ""
    var tryIndex = 0
    var inPlay = false
    var gameStarted : Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    var disabledKeys : Bool {
        !inPlay || currentWord.count == 5
    }
    
    init() {
        newGame()
    }
    
    func newGame() {
        populateDefaults()
        selectedWord = wordChoices.randomElement() ?? "APPLE" 
        currentWord = ""
        tryIndex = 0
        inPlay = true
    }
    
    func populateDefaults() {
        guesses = Array(repeating: Guess(index:0), count: 6)
        for index in 0...5 {
            guesses[index].word = "     "
            guesses.append(Guess(index: index))
        }
        //reset keyboard colors
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in letters {
            keyColours[String(char)] = .gray
        }
        matchedLetter = []
        misplacedLetters = []
    }
    
    func addToCurrentWord(_ letter: String) {
        currentWord += letter
        updateRow()
    }
    
    func enterWord(){
        if currentWord == selectedWord {
            setCurrentGuessColours()
            print("You Win!")
            inPlay = false
            alertType = .win
            rightTime[tryIndex] += 1
        } else {
            if(verifyWord()) {
                print("Valid word")
                setCurrentGuessColours()
                tryIndex += 1
                print("次數\(tryIndex)")
                currentWord = ""
                if tryIndex == 6 {
                    inPlay = false
                    alertType = .lose
                    wrongTime += 1
                    print("You Lose")
                    
                }
            } else {
                self.incorrectAttemps[tryIndex] += 1
                incorrectAttemps[tryIndex] = 0
            }
        }
    }
    
    func removeLetterFromCurrentWord() {
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow() {
        let guessWord = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessWord
    }
    
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
    func setCurrentGuessColours() {
        let correctLetters = selectedWord.map { String($0)}
        var frequency = [String : Int]()
        for letter in correctLetters {
            frequency[letter, default: 0] += 1
        }
        for index in 0...4 {
            let correctLetter = correctLetters[index]
            let guessLetter = guesses[tryIndex].guessLetters[index]
            print("\(index) 猜測字母：\(guessLetter) ")
            print("\(index) 正確字母：\(correctLetter) ")
            if guessLetter == correctLetter {
                guesses[tryIndex].bgColors[index] = .correct
                if !matchedLetter.contains(guessLetter) {
                    matchedLetter.append(guessLetter)
                    keyColours[guessLetter] = .correct
                }
                if(misplacedLetters.contains(guessLetter)) {
                    if let index = misplacedLetters.firstIndex(where: {$0 == guessLetter}) {
                        misplacedLetters.remove(at: index)
                    }
                }
                frequency[guessLetter]! -= 1
            }
        }
        for index in 0...4 {
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if correctLetters.contains(guessLetter) && guesses[tryIndex].bgColors[index] != .correct && frequency[guessLetter]! > 0 {
                guesses[tryIndex].bgColors[index] = .misplaced
                if !misplacedLetters.contains(guessLetter) && !matchedLetter.contains(guessLetter) {
                    misplacedLetters.append(guessLetter)
                    keyColours[guessLetter] = .misplaced
                }
                frequency[guessLetter]! -= 1
            }
        }
        for index in 0...4 {
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if (keyColours[guessLetter] != .correct && keyColours[guessLetter] != .misplaced) {
                keyColours[guessLetter] = .wrong
            }
        }
    }
}
