 ; Read file into memory
 set source="hello.bf"
 open source:readonly
 use source
 read program
 close source
 ; Create output file
 set target="out.txt"
 open target:write
 use target
 ; You can also "use $p" to print to stdout, but it has issues with newlines
 ; Init vm state
 set pc=1
 set dp=0
 for i=0:1:30000 set memory(i)=0
 for i=1:1:$length(program) set jumptarget(i)=-1
 ; Run the program
 ; MUMPS has no while loops, so let's do an infinite loop with a separate post-condition
 ; This will not work without TWO spaces between do and quit - I don't know why
 for i=0:1 do  quit:pc>$length(program)
 . set op=$extract(program,pc)
 . if op=">" set dp=dp+1 set pc=pc+1
 . if op="<" set dp=dp-1 set pc=pc+1
 . if op="+" do
 .. set memory(dp)=memory(dp)+1
 .. set pc=pc+1
 . if op="-" do
 .. set memory(dp)=memory(dp)-1
 .. set pc=pc+1
 . if op="[" do
 .. ; We cache [ jump targets into jumptarget array
 .. ; This speeds up the interpreter somewhat, though it's still dog slow
 .. if jumptarget(pc)=-1 do
 ... set lbrackets=1
 ... set found=0
 ... for j=pc+1:1:$length(program) do  quit:found=1
 .... if $extract(program,j)="[" set lbrackets=lbrackets+1
 .... else  if $extract(program,j)="]" do
 ..... set lbrackets=lbrackets-1
 ..... if lbrackets=0 do
 ...... set jumptarget(pc)=j+1
 ...... set jumptarget(j)=pc+1
 ...... set found=1
 .. if memory(dp)=0 do
 ... set pc=jumptarget(pc)
 .. else  set pc=pc+1
 . if op="]" do
 .. if memory(dp)'=0 set pc=jumptarget(pc)
 .. else  set pc=pc+1
 . if op="." do
 .. write $char(memory(dp))
 .. set pc=pc+1