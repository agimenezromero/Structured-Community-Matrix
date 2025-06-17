# Structured Community Matrix (SCM) Framework

This repository provides Julia code for implementing and analyzing the **Structured Community Matrix (SCM)** framework introduced in:

> Giménez-Romero, À., Hernandez, C., Genovart, M. & Salguero-Gómez, R. *Population structure plays a key role in community stability*. (In review)

## Table of Contents

- [Overview](#overview)
- [Mathematical framework: Derivation of the Structured Community Matrix](#mathematical-framework-derivation-of-the-structured-community-matrix)
- [Repository Contents](#repository-contents)
- [Installation and Requirements](#installation-and-requirements)
- [How to Use](#how-to-use)
- [Empirical Application](#empirical-application)

## Overview

The SCM framework generalizes classical community matrix approaches by incorporating population structure—such as juvenile–adult dynamics—into stability analysis. This allows for a systematic exploration of how stage-specific interactions (e.g., asymmetric predation or competition) affect the stability of both theoretical and empirical communities.

### Mathematical framework: Derivation of the Structured Community Matrix

Consider a dynamical system representing a community of age/stage-structured populations. Let there be $S$ species and $K$ life stages for each species. The system is described by:

$$
\frac{d N^{(k)}_i}{d t}=g^{(k)}_i\left(N^{(1)}_1,\dots,N^{(K)}_1,\dots,N^{(1)}_S,\dots,N^{(K)}_S\right)
$$

where $N_i^{(k)}$ is the density of stage $k$ of species $i$. This formulation can incorporate stage transitions (e.g. aging, reproduction) and inter/intraspecific interactions.

We define:

- Total species abundance:  
  $$\quad N_i = \sum_{k=1}^{K} N_i^{(k)}$$
- Fraction at each stage $k$ (for $k = 1, \dots, K-1$):  
  $$\quad Z_i^{(k)} = \frac{N_i^{(k)}}{N_i}$$
- Final stage as:  
  $$\quad N_i^{(K)} = N_i \left(1 - \sum_{k=1}^{K-1} Z_i^{(k)}\right)$$

The system can then be rewritten in terms of $N_i$ and $Z_i^{(k)}$:

$$
\frac{dN_i}{dt} = f_i(N_j, Z_j^{(1)}, \dots, Z_j^{(K-1)}) \\
\frac{dZ_i^{(k)}}{dt} = f_i^{(k)}(N_j, Z_j^{(1)}, \dots, Z_j^{(K-1)})
$$

This change of variables enables comparison with the traditional community matrix. The structured community matrix $\mathbf{M}_S$ is the Jacobian evaluated at equilibrium $(^*)$:

$$
\mathbf{M}_S =
\begin{bmatrix}
\frac{\partial f_i}{\partial N_j} & \frac{\partial f_i}{\partial Z_j^{(1)}} & \cdots & \frac{\partial f_i}{\partial Z_j^{(K-1)}} \\
\frac{\partial f_i^{(1)}}{\partial N_j} & \frac{\partial f_i^{(1)}}{\partial Z_j^{(1)}} & \cdots & \frac{\partial f_i^{(1)}}{\partial Z_j^{(K-1)}} \\
\vdots & & & \vdots \\
\frac{\partial f_i^{(K-1)}}{\partial N_j} & \frac{\partial f_i^{(K-1)}}{\partial Z_j^{(1)}} & \cdots & \frac{\partial f_i^{(K-1)}}{\partial Z_j^{(K-1)}}
\end{bmatrix}^*
$$

This is a matrix of size $SK \times SK$. The upper-left submatrix $\mathbf{M} = \left(\frac{\partial f_i}{\partial N_j}\right)^*$ corresponds to the traditional (unstructured) community matrix.

To accommodate species with varying numbers of life stages, define $K_{\max}$ and set interaction terms involving non-existing stages to zero.

Random matrix theory can be applied to $\mathbf{M}_S$ to analyze stability properties in general structured systems. In the following examples, we explore how population structure can shift stability outcomes relative to traditional unstructured models.


## Repository Contents

| File                                | Description                                                                 |
|-------------------------------------|-----------------------------------------------------------------------------|
| `SCM_lib.jl`                        | Core Julia library to construct structured community matrices and analyze their stability. |
| `Example.ipynb`                     | Jupyter notebook demonstrating simulations of randomly assembled structured communities. |
| `Example_empirical_food_webs.ipynb` | Notebook applying the SCM framework to empirical food webs from the *Web of Life* database. |

## Installation and Requirements

This repository uses the Julia programming language.

Make sure to install the following Julia packages:

```julia
using Pkg

# Basic libraries needed
Pkg.add("LinearAlgebra")
Pkg.add("Statistics")
Pkg.add("Distributions")

# For distributed computing
Pkg.add("Distributed")
Pkg.add("Distributions")

# To use Jupyter notebooks
Pkg.add("IJulia")
```

## How to Use

- Open `Example.ipynb` to simulate randomly assembled structured communities and analyze their local stability.
- Open `Example_empirical_food_webs.ipynb` to apply the SCM framework to 33 empirical food webs and compare stability outcomes.

## Empirical Application

The empirical simulations rely on food web data from the [Web of Life](https://www.web-of-life.es/) database. These networks provide species richness, connectance, and interaction topologies, thus constraining the number of species, $S$, connectivity, $C$, and the structural properties of the interaction networks empirically.


The results show that cross-stage predator–prey interactions can stabilize empirical networks that are unstable under unstructured models, reinforcing the ecological relevance of population structure.

## License

This project is distributed under the GNU General Public License.
