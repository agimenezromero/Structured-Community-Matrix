using Statistics, LinearAlgebra, Distributions, Distributed, SharedArrays

function structured_community_matrix(n, s, μ, σ_1, σ_2, σ_3, σ_4, C, interaction_type)

    M_1 = zeros(n, n)
    M_2 = zeros(n, n)
    M_3 = zeros(n, n)
    M_4 = zeros(n, n)

    # Off-diagonal elements
    if interaction_type == "random"

        for i in 1:n
            for j in i+1:n
                u = rand()
                if u < C # Species i and j interact

                    # Effect of total abundance of species i on total abundance of species j and vice versa
                    M_1[i, j] = rand(Normal(0, σ_1))
                    M_1[j, i] = rand(Normal(0, σ_1))

                    # Effect of structure of species i on total abundance of species j and vice versa
                    M_2[i, j] = rand(Normal(0, σ_2))
                    M_2[j, i] = rand(Normal(0, σ_2))

                    # Effect of total abundance of species i on structure of species j and vice versa
                    M_3[i, j] = rand(Normal(0, σ_3))
                    M_3[j, i] = rand(Normal(0, σ_3))

                    # Effect of structure of species i on structure of species j and vice versa
                    M_4[i, j] = rand(Normal(0, σ_4))
                    M_4[j, i] = rand(Normal(0, σ_4))

                end
            end
        end

    elseif interaction_type == "random_predation"

        # Random "adult-adult" interactions but predation adult-juvenile interactions

        for i in 1:n
            for j in i+1:n
                u = rand()
                v = rand()
                if u < C # Species i and j interact. 

                    if v < 0.5

                        # i is predator and j is prey

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = rand(Normal(0, σ_1))
                        M_1[j, i] = rand(Normal(0, σ_1))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = rand(Normal(0, σ_4))
                        M_4[j, i] = rand(Normal(0, σ_4))


                    else

                        # i is prey and j is predator

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = rand(Normal(0, σ_1))
                        M_1[j, i] = rand(Normal(0, σ_1))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = rand(Normal(0, σ_4))
                        M_4[j, i] = rand(Normal(0, σ_4))

                    end

                end
            end
        end

    elseif interaction_type == "random_competition"

        # Random "adult-adult" interactions but competitive adult-juvenile interactions

        for i in 1:n
            for j in i+1:n
                u = rand()
                if u < C # Species i and j interact. 

                    # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                    M_1[i, j] = rand(Normal(0, σ_1))
                    M_1[j, i] = rand(Normal(0, σ_1))

                    # Effect on growth rate of species i from changes in structure on species j and vice versa
                    M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                    M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                    # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                    M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                    M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                    # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                    M_4[i, j] = rand(Normal(0, σ_4))
                    M_4[j, i] = rand(Normal(0, σ_4))

                end
            end
        end

    elseif interaction_type == "random_mutualism"

        # Random "adult-adult" interactions but mutualistic adult-juvenile interactions

        for i in 1:n
            for j in i+1:n
                u = rand()
                if u < C # Species i and j interact. 

                    # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                    M_1[i, j] = rand(Normal(0, σ_1))
                    M_1[j, i] = rand(Normal(0, σ_1))

                    # Effect on growth rate of species i from changes in structure on species j and vice versa
                    M_2[i, j] = abs(rand(Normal(0, σ_2)))
                    M_2[j, i] = abs(rand(Normal(0, σ_2)))

                    # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                    M_3[i, j] = abs(rand(Normal(0, σ_3)))
                    M_3[j, i] = abs(rand(Normal(0, σ_3)))

                    # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                    M_4[i, j] = rand(Normal(0, σ_4))
                    M_4[j, i] = rand(Normal(0, σ_4))

                end
            end
        end

    elseif interaction_type == "competition"

        for i in 1:n
            for j in i+1:n
                u = rand()
                if u < C # Species i and j interact

                    # Effect of total abundance of species i on total abundance of species j and vice versa
                    M_1[i, j] = -abs(rand(Normal(0, σ_1)))
                    M_1[j, i] = -abs(rand(Normal(0, σ_1)))

                    # Effect of structure of species i on total abundance of species j and vice versa
                    M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                    M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                    # Effect of total abundance of species i on structure of species j and vice versa
                    M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                    M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                    # Effect of structure of species i on structure of species j and vice versa
                    M_4[i, j] = -abs(rand(Normal(0, σ_4)))
                    M_4[j, i] = -abs(rand(Normal(0, σ_4)))

                end
            end
        end

    elseif interaction_type == "competition_predation"

        # Competitive "adult-adult" interactions but predation adult-juvenile interactions

        for i in 1:n
            for j in i+1:n
                u = rand()
                v = rand()
                if u < C # Species i and j interact. 

                    if v < 0.5

                        # i is predator and j is prey

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = -abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = -abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = -abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = -abs(rand(Normal(0, σ_4)))


                    else

                        # i is prey and j is predator

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = -abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = -abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = -abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = -abs(rand(Normal(0, σ_4)))

                    end

                end
            end
        end

    elseif interaction_type == "competition_mutualism"

        for i in 1:n
            for j in i+1:n
                u = rand()
                if u < C # Species i and j interact

                    # Effect of total abundance of species i on total abundance of species j and vice versa
                    M_1[i, j] = -abs(rand(Normal(0, σ_1)))
                    M_1[j, i] = -abs(rand(Normal(0, σ_1)))

                    # Effect of structure of species i on total abundance of species j and vice versa
                    M_2[i, j] = abs(rand(Normal(0, σ_2)))
                    M_2[j, i] = abs(rand(Normal(0, σ_2)))

                    # Effect of total abundance of species i on structure of species j and vice versa
                    M_3[i, j] = abs(rand(Normal(0, σ_3)))
                    M_3[j, i] = abs(rand(Normal(0, σ_3)))

                    # Effect of structure of species i on structure of species j and vice versa
                    M_4[i, j] = -abs(rand(Normal(0, σ_4)))
                    M_4[j, i] = -abs(rand(Normal(0, σ_4)))

                end
            end
        end

    elseif interaction_type == "mutualism"

        for i in 1:n
            for j in i+1:n
                u = rand()
                if u < C # Species i and j interact

                    # Effect of total abundance of species i on total abundance of species j and vice versa
                    M_1[i, j] = abs(rand(Normal(0, σ_1)))
                    M_1[j, i] = abs(rand(Normal(0, σ_1)))

                    # Effect of structure of species i on total abundance of species j and vice versa
                    M_2[i, j] = abs(rand(Normal(0, σ_2)))
                    M_2[j, i] = abs(rand(Normal(0, σ_2)))

                    # Effect of total abundance of species i on structure of species j and vice versa
                    M_3[i, j] = abs(rand(Normal(0, σ_3)))
                    M_3[j, i] = abs(rand(Normal(0, σ_3)))

                    # Effect of structure of species i on structure of species j and vice versa
                    M_4[i, j] = abs(rand(Normal(0, σ_4)))
                    M_4[j, i] = abs(rand(Normal(0, σ_4)))

                end
            end
        end

    elseif interaction_type == "mutualism_predation"

        # Mutualistic "adult-adult" interactions but predation adult-juvenile interactions

        for i in 1:n
            for j in i+1:n
                u = rand()
                v = rand()
                if u < C # Species i and j interact. 

                    if v < 0.5

                        # i is predator and j is prey

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = abs(rand(Normal(0, σ_4)))


                    else

                        # i is prey and j is predator

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = abs(rand(Normal(0, σ_4)))

                    end

                end
            end
        end

    elseif interaction_type == "mutualism_competition"

        for i in 1:n
            for j in i+1:n
                u = rand()
                if u < C # Species i and j interact

                    # Effect of total abundance of species i on total abundance of species j and vice versa
                    M_1[i, j] = abs(rand(Normal(0, σ_1)))
                    M_1[j, i] = abs(rand(Normal(0, σ_1)))

                    # Effect of structure of species i on total abundance of species j and vice versa
                    M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                    M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                    # Effect of total abundance of species i on structure of species j and vice versa
                    M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                    M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                    # Effect of structure of species i on structure of species j and vice versa
                    M_4[i, j] = abs(rand(Normal(0, σ_4)))
                    M_4[j, i] = abs(rand(Normal(0, σ_4)))

                end
            end
        end

    elseif interaction_type == "mixed"

        error("Not implemented yet")

    elseif interaction_type == "predation"

        for i in 1:n
            for j in i+1:n
                u = rand()
                v = rand()
                if u < C # Species i and j interact. 

                    if v < 0.5

                        # i is predator and j is prey

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = -abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = -abs(rand(Normal(0, σ_4)))


                    else

                        # i is prey and j is predator

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = -abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = -abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = abs(rand(Normal(0, σ_4)))

                    end

                end
            end
        end

    elseif interaction_type == "predation_competition"

        for i in 1:n
            for j in i+1:n
                u = rand()
                v = rand()
                if u < C # Species i and j interact. 

                    if v < 0.5

                        # i is predator and j is prey

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = -abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = -abs(rand(Normal(0, σ_4)))


                    else

                        # i is prey and j is predator

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = -abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = -abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = -abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = -abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = -abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = -abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = abs(rand(Normal(0, σ_4)))

                    end

                end
            end
        end

    elseif interaction_type == "predation_mutualism"

        for i in 1:n
            for j in i+1:n
                u = rand()
                v = rand()
                if u < C # Species i and j interact. 

                    if v < 0.5

                        # i is predator and j is prey

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = -abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = -abs(rand(Normal(0, σ_4)))


                    else

                        # i is prey and j is predator

                        # Effect on growth rate of species i from changes in total abundance of species j and vice versa
                        M_1[i, j] = -abs(rand(Normal(0, σ_1)))
                        M_1[j, i] = abs(rand(Normal(0, σ_1)))

                        # Effect on growth rate of species i from changes in structure on species j and vice versa
                        M_2[i, j] = abs(rand(Normal(0, σ_2)))
                        M_2[j, i] = abs(rand(Normal(0, σ_2)))

                        # Effect on growth rate of structure of species i from changes in total abundance of species j and vice versa
                        M_3[i, j] = abs(rand(Normal(0, σ_3)))
                        M_3[j, i] = abs(rand(Normal(0, σ_3)))

                        # Effect on growth rate of structure of species i from changes in structure of species j and vice versa
                        M_4[i, j] = -abs(rand(Normal(0, σ_4)))
                        M_4[j, i] = abs(rand(Normal(0, σ_4)))

                    end

                end
            end
        end

    else
        error("Invalid interaction type")
    end

    # Diagonal elements
    for i in 1:n
        M_1[i, i] = -μ
        M_2[i, i] = rand(Normal(0, σ_2))
        M_3[i, i] = rand(Normal(0, σ_3))
        M_4[i, i] = -μ
    end

    M = [M_1 M_2; M_3 M_4]

    return M

end

function model(n, s, μ, σ_1, σ_2, σ_3, σ_4, C, interaction_type, realizations)

    stable = SharedArray{Float64}(realizations)

    @sync @distributed for i in 1:realizations

        # Define Jacobian matrix
        J = structured_community_matrix(n, s, μ, σ_1, σ_2, σ_3, σ_4, C, interaction_type)

        # Compute the eigenvalues of the Jacobian matrix
        eigenvalues = eigvals(J)

        # Return maximum real part of the eigenvalues
        λ_max = maximum(real(eigenvalues))

        if λ_max < 0
            stable[i] += 1
        end

    end

    mean_stability = mean(stable)

    std_stability = std(stable)

    return mean_stability, std_stability

end