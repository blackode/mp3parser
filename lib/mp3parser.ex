defmodule Mp3parser do
  @moduledoc """
  This module is used to parse the mp3 file data and gives some useful information
  """

  @doc """
  This function is used to parse the file and gives the map as output .
  """
  def parse file do
    file
    |> check             #checks the file existense
    |> id3tag            #reads the file & returns the id3tag of last 128 bytes of information
    |> parse_id3tag      #parse the tag and returns the map of information like artist,title,etc
    |> display           #display the file information in color format 
  end

  defp id3tag file do
    case file do
      false -> 
        IO.puts IO.ANSI.red <> ":error: file is missing"
        System.halt 0
      file_name -> 
        case File.read(file_name) do
          {:ok,binary} -> 
            mp3_size = byte_size(binary) - 128
            <<_::binary-size(mp3_size),tag::binary>> = binary
            tag
          {:error,reason} -> 
            IO.inspect reason,label: "Failed in reading the file contents"
            System.halt 0
        end
    end
  end

  defp parse_id3tag tag do
    <<"TAG",
      title::binary-size(30),
      artist::binary-size(30),
      album::binary-size(30),
      year::binary-size(4),
      _ignore::binary >> = tag
    %{title: title,artist: artist,album: album,year: year}
  end

  defp display(%{title: title,artist: artist,album: album,year: year} = data)do
    red =    IO.ANSI.red
    yellow = IO.ANSI.yellow
    blue =   IO.ANSI.blue
    green =  IO.ANSI.green

    IO.puts(yellow <> "artis: #{String.trim artist}" <> red <> " | title: #{String.trim title} " <> green <> "| album: (#{String.trim album} | " <> blue <> " year: #{String.trim year}") 
  end

  defp check file do
    if(File.exists? file) do 
      file
    else
      false
    end
  end

end
