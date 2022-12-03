#include <vector>
#include <mutex>
#include <memory>
#include <iostream>

class Table
{
public:
    Table(int size) : size_(size)
    {
        // chopstic_locks_.resize(size);
        for (int i = 0; i < size; ++i)
        {
            chopstic_locks_.emplace_back(new std::mutex);
        }
    }

    int chopstic_number_left(int seat_number)
    {
        return seat_number;
    }

    int chopstic_number_right(int seat_number)
    {
        return (seat_number + 1) >= size_ ? 0 : (seat_number + 1);
    }

    bool take_chopstic_left(int seat_number)
    {
        chopstic_locks_[chopstic_number_left(seat_number)]->lock();
        return true;
    }

    bool take_chopstic_right(int seat_number)
    {
        chopstic_locks_[chopstic_number_right(seat_number)]->lock();
        return true;
    }

    bool put_chopstic_left(int seat_number)
    {
        chopstic_locks_[chopstic_number_left(seat_number)]->unlock();
        return true;
    }

    bool put_chopstic_right(int seat_number)
    {
        chopstic_locks_[chopstic_number_right(seat_number)]->unlock();
        return true;
    }

private:
    int size_;
    std::vector<std::unique_ptr<std::mutex>> chopstic_locks_;
};