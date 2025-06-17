# Structured Community Matrix (SCM) Framework

This repository provides Julia code for implementing and analyzing the **Structured Community Matrix (SCM)** framework introduced in:

> Giménez-Romero, À., Hernandez, C., Genovart, M. & Salguero-Gómez, R. *Population structure plays a key role in community stability*. (In review)

## Overview

The SCM framework generalizes classical community matrix approaches by incorporating population structure—such as juvenile–adult dynamics—into stability analysis. This allows for a systematic exploration of how stage-specific interactions (e.g., asymmetric predation or competition) affect the stability of both theoretical and empirical communities.

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
Pkg.add("IJulia")  # 
```

## How to Use

- Open `Example.ipynb` to simulate randomly assembled structured communities and analyze their local stability.
- Open `Example_empirical_food_webs.ipynb` to apply the SCM framework to 33 empirical food webs and compare stability outcomes.

## Empirical Application

The empirical simulations rely on food web data from the [Web of Life](https://www.web-of-life.es/) database. These networks provide species richness, connectance, and interaction topologies, thus constraining the number of species, $S$, connectivity, $C$, and the structural properties of the interaction networks empirically.


The results show that cross-stage predator–prey interactions can stabilize empirical networks that are unstable under unstructured models, reinforcing the ecological relevance of population structure.

## License

This project is distributed under the GNU General Public License.
