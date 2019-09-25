import DataStructSet

struct Card {
    enum Suits {
        case spade
        case club
        case heart
        case diamond
    }
    enum Rank {
        case ace
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case jack
        case queen
        case king
    }
}

class Deck {
    var deck: Stack<Card>
    init(deck: Stack<Card>) {
        self.deck = deck
    }

    func suffle(){}
    func distribute(players:Int, numOfCard:Int) -> [[Card]]
    { return [[Card]]() }
    func peak() -> Card { return Card() }
    func remainingCard() -> Int {return 0}
}




//#winamp

class Song {
    private var file: String
    private var raw: MediaFormat? // some format mp3
    let totalTime: Int!
    let info: [String: String]
    let artist: String
    init(file: String) {
        self.file = file
        self.totalTime = 20
        self.info = [String: String]()
        self.artist = "Sonu nigam"
    }
}

class Playlist {
    var list: [Song]?
    var current: Int = 0
    func selected() -> Song {
        return list![current]
    }
    func currentList() -> [Song]? {
        return list
    }

    func add(_ new:[Song]) {
        list?.append(contentsOf: new)
    }

    func remove(_ index: Int) { }
    func suffle(){}
    func increment(){ current += 1 }
    func decrement(){ current += 1 }
    func random(){ current = Int(arc4random()) }
}

protocol MediaFormat {}
protocol MediaPlayer {
    func volume(_ bar: Int)
    func play()
    func pause()
    func file(_ raw: MediaFormat)
}

class Dashboard {

    var cplayList: Playlist?
    var mediaPlayer: MediaPlayer!
    var time: Int?

    func next(){ cplayList?.increment() }
    func prev(){ cplayList?.decrement() }
    func slider(_ time: Int) { cplayList?.current }
    func play(_ toggle: Bool) {}
    func elapsedTime() -> Int? { return time }
    func remainingTime() -> Int? { return (cplayList?.selected().totalTime)! - time! }
    func volume(_ bar: Int) { mediaPlayer.volume(bar)}
}

class Library {
    var totalSongs: [Song]?
    func importSongs(_ folder: String) -> [Song]? { return [Song]() }
    func create(_ file: String) -> Song { return Song(file: file) }
    func createPlaylistFromSelection(_ start: Int, _ end: Int) -> Playlist { return Playlist() }
}



//#ParkingLot

struct NumberPlate {
    var number: Int
}
enum VehicleType {
    case bus
    case car
    case byke
}

class Vehicle {
    var type: VehicleType
    init(type: VehicleType) {
        self.type = type
    }
}

class Bus: Vehicle {}
class Car: Vehicle {}
class Byke: Vehicle {}

protocol SlotType {

}

class BykeSlot: SlotType {}
class CarSlot: SlotType {}
class BusSlot: SlotType {}

struct Slot<T> {
    var slotType: T
    var isOccupied: Bool
    var occupied: Vehicle
    var tag: Int
}

class Parking {
    var carSlot: [Slot<CarSlot>]?
    var bykeSlot: [Slot<BykeSlot>]?
    var busSlot: [Slot<BusSlot>]?

    func getEmptyBykeSlot() -> BykeSlot? { return BykeSlot()}
    func getEmptyCarSlot() -> CarSlot? { return CarSlot()}
    func getEmptyBusSlot() -> BusSlot? { return BusSlot()}
    func hashTag(numPlate: NumberPlate) -> Int { return 0 }

    func allocate(vehicle: Vehicle, plate: NumberPlate) -> Slot<SlotType>? {

        switch vehicle.type {
        case .byke:
            if let bslot = getEmptyBykeSlot() {
                return Slot(slotType: bslot, isOccupied: true, occupied: vehicle, tag: hashTag(numPlate: plate))
            }else if let cSlot = getEmptyCarSlot() {
                return Slot(slotType: cSlot, isOccupied: true, occupied: vehicle, tag: hashTag(numPlate: plate))
            }else if let buSlot = getEmptyBusSlot() {
                return Slot(slotType: buSlot, isOccupied: true, occupied: vehicle, tag: hashTag(numPlate: plate))
            }
            return nil
        case .car:
            if let cSlot = getEmptyCarSlot() {
                return Slot(slotType: cSlot, isOccupied: true, occupied: vehicle, tag: hashTag(numPlate: plate))
            }else if let buSlot = getEmptyBusSlot() {
                return Slot(slotType: buSlot, isOccupied: true, occupied: vehicle, tag: hashTag(numPlate: plate))
            }
            return nil
        case .bus:
            if let buSlot = getEmptyBusSlot() {
                return Slot(slotType: buSlot, isOccupied: true, occupied: vehicle, tag: hashTag(numPlate: plate))
            }
            return nil
        }

    }
}

//#online book reader
class Preview {}

class Book {}

class BookLibrary {
    var thumbnails: [BookThumbnail]?
    func login() -> User { return User() }
    func isLoggedin() -> Bool { return true }
    func purchase() -> BookThumbnail { return BookThumbnail() }
    func subscribe() -> BookThumbnail { return BookThumbnail() }
    func readPreview() {}
}

enum BookStatus {
    case purchased
    case subscribe
    case previewOnly
}

class BookThumbnail {
    var status: BookStatus = .previewOnly
    var downloaded: Bool = false
    func isDownloaded() -> Bool { return downloaded }
    func bookStatus() -> BookStatus { return status }
    var book: Book?
    var preview: Preview?
    func read() {}
}

class User {
    var accountInfo: Account?
    var shelf: [BookThumbnail]?

}

class Account {}
