# 🎧 Auditory Attention Modeling & Speech Separation

A biologically inspired spectro-temporal framework for modeling auditory attention and separating concurrent speech signals (Cocktail Party Problem).

---

## 📌 Overview

In real-world environments, multiple sound sources overlap in time and frequency. Despite this, the human auditory system can selectively attend to a target speaker. This project presents a computational model inspired by the human auditory cortex to simulate this phenomenon.

The proposed approach integrates:

* Spectro-temporal analysis
* Harmonic structure modeling
* Multi-resolution auditory representation
* Clustering-based stream segregation

to achieve effective multi-speaker speech separation.

---

## 🧠 Method Summary

The pipeline consists of the following stages:

1. **Spectrogram Estimation (STFT)**
2. **Harmonic Pattern Extraction**
3. **Spectro-Temporal Decomposition (NSL Tools)**
4. **Feature Reduction (Centroid Extraction)**
5. **Clustering (K-means)**
6. **Temporal Tracking of Speech Streams**
7. **Speech Reconstruction**

This approach mimics how auditory cortex neurons encode and group sound features.

---

## 🗂 Repository Structure

```
auditory-attention-speech-separation/
│
├── matlab/
│   ├── src/                  # Clean implementation
│   ├── legacy/               # Original thesis code
│   ├── external/nsltools/    # Auditory toolbox
│   ├── data/
│   │   ├── audio/            # Input signals
│   │   └── templates/        # Harmonic templates
│   ├── results/              # Output files
│   ├── run_demo.m
│   └── add_project_paths.m
│
├── paper/                    # IEEE paper
├── README.md
├── LICENSE
└── .gitignore
```

---

## ⚙️ Requirements

* MATLAB R2018+ (recommended)
* Signal Processing Toolbox
* Statistics and Machine Learning Toolbox

---

## ▶️ How to Run

```matlab
cd('matlab')
add_project_paths
run_demo
```

Or run manually:

```matlab
outputs = run_attention_pipeline( ...
    'data/audio/beshno.wav', ...
    'data/templates/templat.mat', ...
    32, 44100, 100, 'results');
```

---

## 📊 Results

The method successfully separates mixed speech signals using biologically inspired features.

### ✔ Key Observations:

* Clear separation of harmonic structures
* Robust performance across different frame sizes
* Improved perceptual quality (PESQ)

| Frame Length | Baseline | Proposed |
| ------------ | -------- | -------- |
| 8 ms         | 1.85     | 2.31     |
| 16 ms        | 2.02     | 2.58     |
| 32 ms        | 1.90     | 2.44     |

---

## 📄 Paper

This work is based on an M.Sc. thesis and has been extended into an IEEE-style paper.

📌 The paper is available in the `paper/` directory.

---

## 🔬 Key Contributions

* Spectro-temporal modeling of auditory attention
* Harmonicity-based speech feature enhancement
* Dimensionality reduction using centroid features
* Clustering-based speech stream segregation
* Integration with biologically inspired NSL auditory toolbox

---

## ⚠️ Notes

* The NSL Tools toolbox is included for auditory modeling.
* Some functions rely on legacy implementations and may generate MATLAB warnings.
* The project is research-oriented and not optimized for real-time use.

---

## 📚 Citation

If you use this work, please cite:

```
Shirkhan, M. R., Rezazi, F., & Ghasemian Yazdi, M. H.
A Spectro-Temporal Framework for Auditory Attention Modeling.
```

---

## 👨‍💻 Author

**Mohammad Reza Shirkhan**
M.Sc. in Electrical Engineering (Telecommunications)

---

## 📬 Contact

📧 [r.shirkhan@gmail.com](mailto:r.shirkhan@gmail.com)

---

## ⭐ Acknowledgment

This work was conducted under the supervision of:

* Dr. Farbod Rezazi
* Dr. Mohammad Hassan Ghasemian Yazdi

---

## 📜 License

This project is licensed under the MIT License.
