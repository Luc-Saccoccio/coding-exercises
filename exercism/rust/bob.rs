pub fn reply(message: &str) -> &str {
    let m: &str = message.trim();
    if m.is_empty() {
        return "Fine. Be that way!";
    }
    let question: bool = m.ends_with('?');
    let capitals: bool =
        m.chars().filter(|c| c.is_alphabetic()).count() > 0 && m.to_uppercase() == m;
    if question {
        if capitals {
            return "Calm down, I know what I'm doing!";
        }
        return "Sure.";
    } else if capitals {
        return "Whoa, chill out!";
    }
    "Whatever."
}
