#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32),
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {
    let mut stack = Vec::new();
    for input in inputs {
        match input {
            CalculatorInput::Add => {
                let r = stack.pop()?;
                let l = stack.pop()?;
                stack.push(l + r);
            },
            CalculatorInput::Subtract => {
                let r = stack.pop()?;
                let l = stack.pop()?;
                stack.push(l - r);
            },
            CalculatorInput::Multiply => {
                let r = stack.pop()?;
                let l = stack.pop()?;
                stack.push(l * r);
            },
            CalculatorInput::Divide => {
                let r = stack.pop()?;
                let l = stack.pop()?;
                stack.push(l / r);
            },
            CalculatorInput::Value(v) => stack.push(*v)
        }
    }
    let output = stack.pop();
    if stack.is_empty() { output } else { None }
}
