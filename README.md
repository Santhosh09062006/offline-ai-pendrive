# 🚀 Offline AI Pendrive

A portable, plug-and-play AI chatbot that runs **100% offline** directly from any USB flash drive on any Windows computer — **no installation, no admin rights, and no internet connection required**.

Powered by [`llama.cpp`](https://github.com/ggerganov/llama.cpp) and quantized GGUF models (default: **Llama 3.2 3B Instruct**).

---

## ✨ Features

- **🔒 100% Offline & Private:** All inference happens locally in the host machine's RAM/CPU. Zero data is sent across the network.
- **🔌 Plug & Play:** Carry your personal AI in your pocket. Plug it into any Windows PC, double-click `Start-AI.bat`, and start chatting.
- **⚡ Universal CPU Support:** Automatically detects CPU microarchitectures and auto-tunes threads for **Intel Core i3 / i5 / i7** and **AMD Ryzen 3 / 5 / 7**.
- **🌐 Clean Web UI:** Automatically opens an offline, ChatGPT-like browser interface at `http://127.0.0.1:8080`.
- **🛠️ Zero Tool Hallucination:** Ships with a custom clean Jinja template (`template.jinja`) that disables tool injection overhead, ensuring the AI responds with pure text and code.

---

## 📁 Repository Structure

```text
offline-ai-pendrive/
├── .gitignore               # Prevents large models (>100MB) from being committed
├── README.md                # Documentation and setup guide
├── setup.bat                # 1-click automated downloader for engine & model
├── Start-AI.bat             # 1-click offline launcher
└── template.jinja           # Clean chat template preventing tool hallucinations
```

---

## 🚀 Quick Start (Setting Up a New USB Drive)

### 1. Format your USB Drive (Recommended)
Format your USB drive as **exFAT** or **NTFS** (to avoid the 4 GB single-file limit of FAT32).

### 2. Clone this Repository onto your USB Drive
Open Command Prompt or Terminal on your USB drive (e.g., `D:\`) and run:
```bash
git clone https://github.com/YOUR_USERNAME/offline-ai-pendrive.git .
```
*(Or download this repository as a ZIP and extract its files directly into the root of your USB drive)*.

### 3. Run the Automated Setup
Double-click **`setup.bat`**.  
*This only requires an internet connection once to automatically download:*
- The lightweight portable `llama.cpp` Windows engine (~18 MB).
- The quantized `Llama-3.2-3B-Instruct-Q4_K_M.gguf` model (~1.88 GB).
- Copies the clean chat template into the engine directory.

### 4. Start Chatting (100% Offline)
Whenever you want to use the AI:
1. Double-click **`Start-AI.bat`**.
2. Your default web browser will automatically open to `http://127.0.0.1:8080`.
3. Start asking questions, generating code, or analyzing text completely offline!
4. To stop the AI and unload memory, simply close the black terminal window.

---

## 🎯 Adding More Models

You can store multiple models on the pendrive!

1. Download any quantized `.gguf` model from [Hugging Face](https://huggingface.co/models?search=gguf) (e.g., `Qwen2.5-Coder-3B`, `Phi-3.5-mini`, etc.).
2. Save the `.gguf` file inside the `Models/` folder on your USB drive.
3. Next time you launch `Start-AI.bat`, it will automatically list all available models and ask which one you want to run.

---

## 💻 Hardware Requirements

- **Operating System:** 64-bit Windows 10 or 11.
- **RAM:** Minimum 8 GB RAM (the 3B model and 8k context use ~3.5 GB to 4 GB).
- **USB Drive:** Minimum 8 GB capacity (USB 3.0 / 3.2 recommended for fast model loading).

---

## 📜 License

MIT License. Free for personal and commercial use.
