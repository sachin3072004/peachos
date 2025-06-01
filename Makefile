all:
	nasm -f bin ./src/boot/boot.asm -o ./build/boot.bin
clean:
	rm -rf ./bin/boot.bin
