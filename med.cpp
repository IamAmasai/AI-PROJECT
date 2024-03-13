#include <iostream>
#include <vector>

// Define a class for representing a medical facility
class MedicalFacility {
public:
    // Constructor
    MedicalFacility(const std::string& name) : name(name) {}

    // Getter for the facility name
    std::string getName() const {
        return name;
    }

private:
    std::string name;
};

// Define a class for representing a medical service
class MedicalService {
public:
    // Constructor
    MedicalService(const std::string& name, double price) : name(name), price(price) {}

    // Getter for the service name
    std::string getName() const {
        return name;
    }

    // Getter for the service price
    double getPrice() const {
        return price;
    }

private:
    std::string name;
    double price;
};

// Define a class for the booking system
class BookingSystem {
public:
    // Function to book a medical service at a facility
    void bookService(const MedicalFacility& facility, const MedicalService& service) {
        // Add your booking logic here
        std::cout << "Booking service " << service.getName() << " at facility " << facility.getName() << std::endl;
    }

private:
    // Add any necessary data members or helper functions here
};

/**
 * The main function is the entry point of the program.
 * It creates medical facilities, medical services, and a booking system.
 * It then books a service at a facility using the booking system.
 *
 * @return 0 indicating successful execution of the program.
 */
int main() {
    // Create some medical facilities
    MedicalFacility facility1("Hospital A");
    MedicalFacility facility2("Clinic B");

    // Create some medical services
    MedicalService service1("Consultation", 50.0);
    MedicalService service2("MRI", 200.0);

    // Create a booking system
    BookingSystem bookingSystem;

    // Book a service at a facility
    bookingSystem.bookService(facility1, service1);
    bookingSystem.bookService(facility2, service2);

    return 0;
}
