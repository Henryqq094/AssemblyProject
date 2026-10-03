# 期末實作：Julia Set 動畫

以 C 控制程式流程與 Linux framebuffer 輸出，並透過 ARM 組合語言完成成員資料處理及 Julia Set 像素計算。

## 功能與流程

1. 顯示隊伍與組員姓名。
2. 讀取三筆整數 ID，輸入小寫 `p` 後顯示 ID 與總和。
3. 整合輸出姓名、ID 與總和。
4. 再輸入小寫 `p`，開始計算並顯示 Julia Set 動畫。
5. 動畫結束後顯示新年祝福與組員資料，再輸入小寫 `p` 結束程式。

在終端機輸入時，每次輸入後按 Enter。

## 檔案說明

| 檔案 | 用途 |
| --- | --- |
| `main.c` | 主流程、動畫參數、影像緩衝區 |
| `name.s` | 輸出隊伍及姓名，並提供 C 程式使用的姓名字串 |
| `id.s` | ID 輸入、加總與輸出，並提供 `ids`、`idsum` |
| `drawJuliaSet.s` | `drawJuliaSet` 函式，計算各像素的迭代結果並寫入影像緩衝區 |

## Julia Set 計算

對每個像素映射出的複數座標，反覆計算 `z ← z² + c`。原始碼以整數搭配 1000 倍縮放表示座標：

```text
next_zx = (zx * zx - zy * zy) / 1000 + cX
next_zy = (2 * zx * zy) / 1000 + cY
```

兩個式子均使用更新前的 `zx`、`zy`。當 `zx² + zy² >= 4,000,000` 或剩餘迭代次數為零時停止，以剩餘迭代次數組合成 16 位元像素值。

| 參數 | 設定 |
| --- | --- |
| 畫面尺寸 | 640 × 480 |
| 像素儲存大小 | 16 位元 |
| 每像素最大迭代次數 | 255 |
| `cX` | -700（縮放前為 -0.7） |
| `cY` | 400 至 270，每次減少 5 |
| 畫面數 | 27 |

## 執行環境

- 32 位元 ARM Linux，搭配 GCC 與 C 標準函式庫。
- framebuffer 須與 640 × 480、16 位元像素、每列 1280 bytes 的配置相容。

程式直接寫入 framebuffer，不會建立桌面視窗，也未自動查詢或設定螢幕格式。僅有終端機的環境若沒有相容的 framebuffer，便無法顯示動畫。

## 編譯與執行

在目標 ARM Linux 環境，從本資料夾執行：

```sh
gcc -include unistd.h -o test main.c name.s id.s drawJuliaSet.s
./test
```

原始 `main.c` 使用 `write`、`lseek`、`close`，但未引入 `<unistd.h>`；此處以 `-include unistd.h` 在編譯時補入宣告，保留原始碼不變。編譯範例尚未在目標 ARM 裝置驗證。

## 使用限制

- framebuffer 無法開啟時，程式會顯示 `Frame Buffer Device Open Error!!`，之後仍需輸入 `p` 才會結束。
- 原始碼未處理短寫入、顯示格式不符或非整數 ID 等情況。
- 繪圖函式內固定使用 640 像素的列寬；若調整畫面尺寸，需同步檢查 C 與組合語言的記憶體配置。

[返回專案總覽](../README.md)
