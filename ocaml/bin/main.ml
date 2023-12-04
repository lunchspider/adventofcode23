let file = "../inputs/2.txt"

(*let print_list = List.iter (Printf.printf "%s\n");*)

type round = { mutable red : int; mutable blue: int; mutable green: int}

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
    Printf.printf "red = %d , blue = %d, green = %d " round_info.red round_info.blue round_info.green

let parse_game str = 
    let x = List.map String.trim (String.split_on_char ':' str) in 
    match x with
        | [] -> ();
        | _::y -> List.iter parse_round (List.map (String.split_on_char ';') y |> List.flatten)

let rec parse_file channel =  
    match input_line channel with
        | line -> parse_game line;
        parse_file channel
    | exception End_of_file ->
     close_in channel


let () = parse_file @@ open_in file;;
