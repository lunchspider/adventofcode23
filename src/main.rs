mod solutions;

use std::path::PathBuf;

use clap::Parser;

#[derive(Parser, Debug)]
struct Args {
    #[arg(short, long)]
    name: u8,

    #[arg(short, long)]
    input: String,
}

fn main() {
    let args = Args::parse();
    let day = args.name;
    let input_file = PathBuf::from(args.input);
    if !input_file.exists() {
        panic!("{:?} doesn't exist.", input_file)
    }

    match day {
        1 => solutions::day1::first(input_file),
        _ => panic!("day coutn wrong"),
    }
}
