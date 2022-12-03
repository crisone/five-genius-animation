#include <iostream>
#include <mutex>
#include <chrono>

using namespace std::chrono;
class Logger
{
public:
    Logger()
    {
        milliseconds_begin_ = duration_cast<milliseconds>(
            system_clock::now().time_since_epoch());
    }

    void print(std::string msg)
    {
        mu.lock();
        // std::cout << msg << std::endl;
        mu.unlock();
    }

    void ChangeGeniusStatus(int idx, int status)
    {
        mu2.lock();
        genius_status_[idx] = status;
        DumpStatus();
        mu2.unlock();
    }
    void ChangeChopStatus(int idx, int status)
    {
        mu2.lock();
        chop_status_[idx] = status;
        DumpStatus();
        mu2.unlock();
    }

    void DumpStatus()
    {
        using namespace std::chrono;
        milliseconds ms = duration_cast<milliseconds>(
            system_clock::now().time_since_epoch());

        milliseconds interval = ms - milliseconds_begin_;

        // const auto p1 = std::chrono::system_clock::now();
        std::string s = "{\"time\":" + std::to_string(interval.count()) + ", ";
        s += "\"gstatus\": ";
        s += ArrayToString(genius_status_, 5);
        s += ", \"cstatus\":";
        s += ArrayToString(chop_status_, 5);
        s += "}, ";
        std::cout << s << std::endl;
    }

    std::string ArrayToString(int a[], int count)
    {
        std::string t = "[";
        for (int i = 0; i < count; ++i)
        {
            t += std::to_string(a[i]);
            if (i < count - 1)
            {
                t += ",";
            }
        }
        t += "]";
        return t;
    }

private:
    std::mutex mu;
    std::mutex mu2;

    milliseconds milliseconds_begin_;

    int genius_status_[5] = {0, 0, 0, 0, 0};
    int chop_status_[5] = {0, 0, 0, 0, 0};
};