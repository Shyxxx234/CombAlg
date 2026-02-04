#include <iostream>
#include <chrono>
#include <algorithm>
#include <vector>
#include <stdexcept>
#include <fstream>

int main()
{
    try {
        std::ifstream fin("input.txt");
        int cityCount;
        int minAmountOfMetres = INT_MAX;

        if (!fin.eof())
        {
            fin >> cityCount;
        }
        else
        {
            std::cerr << "Enter a number greater than 2" << std::endl;
            throw std::invalid_argument("Enter a number greater than 2");
        }
        if (cityCount < 2)
        {
            std::cerr << "Enter a number greater than 2" << std::endl;
            throw std::invalid_argument("Enter a number greater than 2");
        }
        std::vector<std::vector<int>> roads(cityCount, std::vector<int>(cityCount));
        std::vector<int> minCityOrder(cityCount);
        std::vector<int> cityOrder(cityCount);
        for (int i = 0; i < cityCount; i++) cityOrder[i] = i;

        auto start = std::chrono::steady_clock::now();
        for (int i = 0; i < cityCount; i++)
        {
            for (int j = 0; j < cityCount; j++)
            {
                int n;
                if (!fin.eof())
                {
                    fin >> n;
                }
                else
                {
                    {
                        std::cerr << "Insufficient number of arguments" << std::endl;
                        throw std::invalid_argument("Insufficient number of arguments");
                    }
                }
                roads[i][j] = n;
            }
        }

        do
        {
            int totalDistance = 0;
            for (int i = 0; i < cityCount - 1; i++) totalDistance += roads[cityOrder[i]][cityOrder[i + 1]];
            totalDistance += roads[cityOrder[cityCount - 1]][cityOrder[0]];

            if (totalDistance < minAmountOfMetres)
            {
                minAmountOfMetres = totalDistance;
                minCityOrder = cityOrder;
            }
        } while (std::next_permutation(cityOrder.begin(), cityOrder.end()));
        auto end = std::chrono::steady_clock::now();

        std::cout << "Amount of metres: " << minAmountOfMetres << std::endl;
        for (int i = 0; i < cityCount; i++) std::cout << minCityOrder[i] << " ";
        std::cout << std::endl;
        std::cout << "Execution time: " << std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count() << " ms" << std::endl;

        return 0;
    }
    catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
    catch (...) {
        std::cerr << "Unknown error occurred" << std::endl;
        return 1;
    }
}