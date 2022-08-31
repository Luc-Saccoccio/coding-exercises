package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch card {
		case "ace":
			return 11
		case "eight":
			return 8
		case "two":
			return 2
		case "nine":
			return 9
		case "three":
			return 3
		case "four":
			return 4
		case "jack", "ten", "king", "queen":
			return 10
		case "five":
			return 5
		case "six":
			return 6
		case "seven":
			return 7
		default:
			return 0
	}
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	var dealerCardValue int = ParseCard(dealerCard)
	var myCardSum int = ParseCard(card1) + ParseCard(card2)
	switch {
	case ParseCard(card1) == 11 && ParseCard(card2) == 11:
		return "P"
	case myCardSum == 21 && (dealerCardValue != 11 && dealerCardValue != 10):
		return "W"
	case (myCardSum == 21) && (dealerCardValue == 11 || dealerCardValue == 10):
		return "S"
	case (myCardSum >= 17 && myCardSum <= 20):
		return "S"
	case (myCardSum >= 12 && myCardSum <= 16) && (dealerCardValue < 7):
		return "S"
	case (myCardSum >= 12 && myCardSum <= 16) && (dealerCardValue >= 7):
		return "H"
	case (myCardSum <= 11):
		return "H"
	}
	return ""
}
