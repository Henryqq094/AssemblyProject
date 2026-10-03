# ARM 組合語言與嵌入式系統實作

本專案收錄期中與期末的 ARM 組合語言實作。期中以組合語言完成成員資料輸入、輸出及加總；期末結合 C 與組合語言，計算 Julia Set 並透過 Linux framebuffer 顯示動畫。

## 專案內容

| 實作 | 功能 | 語言 |
| --- | --- | --- |
| [期中](期中/README.md) | 顯示組員姓名、輸入三筆 ID、計算總和並整合輸出 | ARM Assembly |
| [期末](期末/README.md) | 整合成員資料與 Julia Set 動畫，將影像寫入 framebuffer | C、ARM Assembly |

```text
.
├── README.md
├── .gitignore
├── 期中/
│   ├── README.md
│   ├── main.s
│   ├── name.s
│   └── id.s
└── 期末/
    ├── README.md
    ├── main.c
    ├── name.s
    ├── id.s
    └── drawJuliaSet.s
```

## 執行環境

- 32 位元 ARM Linux 與相容的 GCC 工具鏈、C 標準函式庫。
- 原始碼使用 GNU ARM 組合語言語法，無法直接以 Windows／x86 或 AArch64 原生編譯器執行。
- 期末另需可存取的 `/dev/fb0`，其顯示格式須與程式使用的 640 × 480、每像素 16 位元及每列 1280 bytes 配置相容。

各子資料夾的 README 提供功能說明、編譯範例與操作流程。編譯指令依原始碼整理，尚未在目標 ARM 裝置上驗證。

## 收錄範圍

本儲存庫保留實作原始碼與使用說明，不包含作業說明、繳交報告、教材、壓縮包或編譯完成的執行檔。原始程式內容保持不變。
