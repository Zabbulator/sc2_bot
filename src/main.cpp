#include <iostream>

#include <sc2api/sc2_api.h>

using namespace sc2;

class Bot : public Agent {
public:
    virtual void OnGameStart() {
        std::cout << "Hello World!" << std::endl;
    }
};

int main(int argc, char* argv[])
{
    Coordinator coordinator;
    coordinator.LoadSettings(argc, argv);

    Bot bot;
    coordinator.SetParticipants({
                                    CreateParticipant(Race::Zerg, &bot),
                                    CreateComputer(Race::Terran)
                                });

    coordinator.LaunchStarcraft();
    coordinator.StartGame(sc2::kMapBelShirVestigeLE);

    return 0;
}
