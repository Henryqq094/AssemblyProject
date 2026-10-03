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

各子資料夾的 README 提供功能說明、編譯範例與操作流程。

