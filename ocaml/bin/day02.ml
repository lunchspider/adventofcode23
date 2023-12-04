type round = { mutable red : int; mutable blue: int; mutable green: int}

let result = ref 0;;

let handle_round round_info r = 
    let r = List.map String.trim (String.split_on_char ' ' r) in
    let num = (match (List.nth r 0 |> int_of_string_opt) with 
        | Some x -> x 
        | None -> 0) in
    let color = List.nth r 1 in
    match color with
        | "green" -> round_info.green <- max round_info.green num
        | "blue" -> round_info.blue <- max round_info.blue num
        | "red" -> round_info.red <- max round_info.red num
        | _ -> ()

let parse_round rounds = 
    let round_info  = { red = 0; blue = 0; green = 0;} in
    let x = List.map String.trim (String.split_on_char ',' rounds) in
    List.iter (handle_round round_info) x;
    if round_info.red <= 12 && round_info.green <= 13 && round_info.blue <= 14 then
        true
    else false


let parse_game game_number str = 
    let is_game_possible = ref true in
    let x = List.map String.trim (String.split_on_char ':' str) in 
    match x with
        | [] -> ();
        | _::y -> let rounds = (List.map (String.split_on_char ';') y |> List.flatten) in
        List.iter (fun x -> is_game_possible := !is_game_possible && parse_round x) rounds;
    if !is_game_possible then
        result := !result + game_number

let rec parse_file game_number channel =  
    match input_line channel with
    | line -> parse_game game_number line;
        parse_file (game_number + 1) channel
    | exception End_of_file ->
     close_in channel


let first file = (open_in file |> parse_file 1); !result;;

let () = 
    Printf.printf "%d" @@ first "../inputs/2.txt";;
