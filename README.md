# mkdir_project_c_asm

`mkdir_project_c_asm` is a low-level implementation of the Linux `mkdir` command, written in **C** and **x86_64 Assembly**.

This project demonstrates how to create directories by interacting directly with the Linux kernel using system calls, providing an educational insight into how simple Linux utilities work internally.

---

## 📂 Project Structure

```
mkdir_project_c_asm/
├── C_version/
│   └── main.c
├── ASM_version/
│   └── main.asm
└── README.md
```

* **C_version/**:
  Implementation of `mkdir` using C and Linux system calls.
* **ASM_version/**:
  Implementation using x86_64 Assembly with direct syscalls.

---

## ✨ Features

* Create directories
* Support for custom permissions
* Manual handling of Linux system calls
* Educational focus on low-level system programming

---

## 🛠️ Compilation

### C Version

```bash
gcc main.c -o mkdir_project
```

### Assembly Version

```bash
nasm -f elf64 main.asm -o program.o
ld program.o -o mkdir_project
```

---

## 🚀 Usage

```bash
./mkdir_project directory_name
```

This will create a new directory with the specified name.

---

## 🎯 Goals of This Project

* Learn how the `mkdir` command works internally
* Practice system programming with C and Assembly
* Understand Linux syscalls and kernel interaction
* Improve debugging skills using tools like `gdb`

---

## ⚠️ Warning

This project is for **educational purposes only**.

---

## 👨‍💻 Author

**Soulaimane**
Computer Science student
Interested in:

* Low-level programming
* Linux internals
* Reverse engineering
* Cybersecurity
