defmodule CLI do 
   def main(args) do
     {options,_,_} = OptionParser.parse(args,switches: [file: :string],aliases: [f: :file])
     case options[:file] || nil do
       nil ->
         IO.puts """
         oops you are using wrong!
         =========================

         #usage
           mp3parser -f filepath
           or 
           mp3parser --file filpath
           of
           mp3parser --file=filepath
         """
      file ->
       Mp3parser.parse options[:file]
     end

   end
end
