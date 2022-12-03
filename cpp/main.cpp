#include <iostream>
#include <vector>
#include <chrono>
#include <thread>

#include "logger.h"
#include "table.h"

void genius_life(Table *table, int seat, Logger *logger)
{
    int eats = 0;
    while (true)
    {
        // take chopstics
        logger->print("Genius " + std::to_string(seat) + " start to take chopstics");
        logger->ChangeGeniusStatus(seat, 1);

        table->take_chopstic_left(seat);
        logger->ChangeChopStatus(table->chopstic_number_left(seat), 1);
        std::this_thread::sleep_for(std::chrono::seconds(1));
        table->take_chopstic_right(seat);
        logger->ChangeChopStatus(table->chopstic_number_right(seat), -1);
        std::this_thread::sleep_for(std::chrono::seconds(1));

        // if (table->chopstic_number_left(seat) < table->chopstic_number_right(seat))
        // {
        //     table->take_chopstic_left(seat);
        //     logger->ChangeChopStatus(table->chopstic_number_left(seat), 1);
        //     std::this_thread::sleep_for(std::chrono::seconds(1));
        //     table->take_chopstic_right(seat);
        //     logger->ChangeChopStatus(table->chopstic_number_right(seat), -1);
        //     std::this_thread::sleep_for(std::chrono::seconds(1));
        // }
        // else
        // {
        //     table->take_chopstic_right(seat);
        //     logger->ChangeChopStatus(table->chopstic_number_right(seat), -1);
        //     std::this_thread::sleep_for(std::chrono::seconds(1));
        //     table->take_chopstic_left(seat);
        //     logger->ChangeChopStatus(table->chopstic_number_left(seat), 1);
        //     std::this_thread::sleep_for(std::chrono::seconds(1));
        // }

        // eat
        logger->ChangeGeniusStatus(seat, 2);
        logger->print("Genius " + std::to_string(seat) + " start to eat");
        std::this_thread::sleep_for(std::chrono::seconds(3));

        // put chopstics
        table->put_chopstic_left(seat);
        logger->ChangeChopStatus(table->chopstic_number_left(seat), 0);
        table->put_chopstic_right(seat);
        logger->ChangeChopStatus(table->chopstic_number_right(seat), 0);
        logger->ChangeGeniusStatus(seat, 3);
        eats++;
        logger->print("Genius " + std::to_string(seat) + " finished eat, total eats: " + std::to_string(eats));

        // think
        std::this_thread::sleep_for(std::chrono::seconds(5));
    }
}

int main(int argc, char *argv[])
{
    Table table(5);
    Logger logger;

    std::vector<std::thread> threads;
    for (int i = 0; i < 5; ++i)
    {
        threads.emplace_back(genius_life, &table, i, &logger);
    }

    for (auto &t : threads)
    {
        t.join();
    }

    return 0;
}