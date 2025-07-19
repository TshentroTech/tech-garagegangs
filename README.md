# 🚗 tech-garagegangs Vehicle System

A comprehensive and secure gang vehicle management system for QBCore Framework with advanced features including gang-specific vehicle restrictions, speed limits, and passenger-friendly access control.

![Version](https://img.shields.io/badge/version-1.2.0-blue.svg)
![QBCore](https://img.shields.io/badge/QBCore-Compatible-green.svg)
![License](https://img.shields.io/badge/license-MIT-yellow.svg)

## 📋 Table of Contents

- [Features](#-features)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Usage](#-usage)
- [API Reference](#-api-reference)
- [Security Features](#-security-features)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

### 🚗 **Gang Vehicle Management**
- **Gang-Specific Vehicles**: Each gang has designated vehicles that only gang members can access
- **Vehicle Restrictions**: Non-gang members cannot drive gang vehicles
- **Passenger-Friendly**: Anyone can be a passenger, but only gang members can drive
- **Secure Spawning**: Server-side validation ensures only authorized players can spawn vehicles
- **Automatic Cleanup**: Vehicles are automatically cleaned up when players disconnect

### 🎨 **Custom Vehicle Colors**
- **Themed Color Schemes**: Each gang has meaningful colors that match their identity
- **Automatic Application**: Colors are automatically applied when vehicles are spawned
- **Customizable**: Easy to modify colors in the configuration

### ⚡ **Speed Limit System**
- **Custom Speed Limits**: Configurable speed limits for specific vehicles (e.g., 270 km/h)
- **Silent Enforcement**: Automatic speed reduction without notification spam
- **Real-time Monitoring**: Continuous speed monitoring and enforcement
- **Vehicle-Specific**: Different speed limits for different vehicle types

### 🔒 **Advanced Security**
- **Server-Side Validation**: All vehicle spawning is validated on the server
- **Gang Membership Checks**: Real-time verification of gang membership
- **Vehicle Ownership Tracking**: All spawned vehicles are tracked and managed
- **Anti-Exploit Protection**: Prevents unauthorized vehicle access and spawning
- **Gang Change Detection**: Automatically handles gang membership changes

## 🚀 Installation

### Prerequisites
- QBCore Framework
- qb-menu (for menu system)
- Fuel system (configurable: lc_fuel, ps-fuel, lj-fuel, LegacyFuel)

### Installation Steps

 **Add to server.cfg**
   ```cfg
   ensure tech-garagegangs
   ```

4. **Configure Gangs**
   - Edit `config.lua` to add your gangs
   - Set vehicle spawner locations
   - Configure vehicle lists and colors

5. **Restart Server**
   ```bash
   restart tech-garagegangs
   ```

## ⚙️ Configuration

### Gang Setup

Each gang in `config.lua` requires the following structure:

```lua
["gangname"] = {
    ["VehicleSpawner"] = vector4(x, y, z, heading), -- Vehicle spawn location
    ["colors"] = { primary_color, secondary_color }, -- Vehicle colors
    ["vehicles"] = {
        ["vehicle_model"] = "Display Name", -- Available vehicles
    },
}
```

### Speed Limits

Configure speed limits for specific vehicles:

```lua
Config.SpeedLimits = {
    ["vehicle_model"] = speed_limit_kmh, -- Speed limit in km/h
}
```

### Fuel System

Configure your fuel system:

```lua
Config.Fuel = 'lc_fuel' -- Options: ps-fuel, lj-fuel, LegacyFuel
```

### Example Configuration

```lua
Config.Gangs = {
    ["wolves"] = {
        ["VehicleSpawner"] = vector4(721.99, -686.97, 27.11, 356.39),
        ["colors"] = { 156, 156 }, -- Silver/Gray
        ["vehicles"] = {
            ["enduro"] = "Enduro Motorcycle",
            ["buccaneer"] = "Buccaneer Car"
        },
    },
    ["castro"] = {
        ["VehicleSpawner"] = vector4(175.73, 1690.01, 227.73, 190.69),
        ["colors"] = { 0, 0 }, -- Black
        ["vehicles"] = {
            ["zx10r"] = "ZX10R Motorcycle",
            ["venatusc"] = "Venatus Car"
        },
    }
}

Config.SpeedLimits = {
    ["zx10r"] = 270,
    ["venatusc"] = 270,
    ["abhawk"] = 270,
}
```

## 🎮 Usage

### For Players

#### **Accessing Vehicle Garage**
1. Go to your gang's vehicle spawner location
2. Press `E` to open the gang menu
3. Select "Vehicle List" to see available vehicles
4. Choose a vehicle to spawn

#### **Vehicle Controls**
- **Spawn Vehicle**: Select from your gang's available vehicles
- **Store Vehicle**: Use the store vehicle option in the menu
- **Passenger Access**: Anyone can ride as a passenger in gang vehicles
- **Driver Restrictions**: Only gang members can drive their gang's vehicles

#### **Speed Limits**
- High-performance vehicles have automatic speed limits (270 km/h)
- Speed is automatically reduced when limit is exceeded
- No notification spam - silent enforcement

### For Administrators

#### **Adding New Gangs**
1. Add gang configuration to `config.lua`
2. Set vehicle spawner coordinates
3. Configure available vehicles
4. Set gang colors

#### **Modifying Vehicles**
- Update the vehicles list for each gang
- Add or remove speed limits
- Change vehicle colors

#### **Adjusting Locations**
- Modify spawner coordinates as needed
- Ensure locations are accessible and safe

## 🔧 API Reference

### Client Events

#### **tech-garagegangs:client:VehicleList**
Opens the vehicle selection menu for the player's gang.

#### **tech-garagegangs:client:SpawnListVehicle**
Triggers vehicle spawning with server-side validation.

#### **tech-garagegangs:client:VehicleDelet**
Stores/removes the current vehicle.

#### **tech-garagegangs:client:SpawnVehicleConfirmed**
Handles confirmed vehicle spawning after server validation.

### Server Events

#### **tech-garagegangs:server:SpawnVehicle**
Server-side validation for vehicle spawning.

#### **tech-garagegangs:server:LogVehicleUsage**
Logs vehicle usage for monitoring and debugging.

#### **tech-garagegangs:server:ValidateGangVehicle**
Validates gang membership and vehicle access.

### Configuration Variables

| Variable | Type | Description |
|----------|------|-------------|
| `Config.Fuel` | string | Fuel system to use |
| `Config.SpeedLimits` | table | Speed limits for vehicles |
| `Config.Gangs` | table | Gang configurations |

## 🔒 Security Features

### Vehicle Restrictions
- **Gang-Only Driving**: Only gang members can drive their gang's vehicles
- **Passenger Access**: Anyone can be a passenger
- **Real-time Validation**: Continuous checking of gang membership
- **Server-Side Security**: All actions validated on server

### Anti-Exploit Measures
- **Ownership Tracking**: Each vehicle is tagged with gang ownership
- **Gang Change Detection**: Automatic handling of gang membership changes
- **Vehicle Cleanup**: Automatic cleanup when players disconnect
- **Speed Limit Enforcement**: Prevents unrealistic speeds

### Access Control
- **Driver Seat Restrictions**: Only authorized drivers can use driver seat
- **Gang Membership Verification**: Real-time gang membership checks
- **Vehicle Spawn Validation**: Server-side validation for all vehicle spawning

## 🛠️ Troubleshooting

### Common Issues

#### **Vehicles Not Spawning**
- Check if player is in a gang
- Verify gang configuration in `config.lua`
- Ensure vehicle models are valid
- Check server console for errors

#### **Speed Limits Not Working**
- Verify speed limits are configured in `Config.SpeedLimits`
- Check if vehicle model matches configuration
- Ensure script is properly loaded

#### **Permission Errors**
- Verify gang membership
- Check gang configuration
- Ensure proper QBCore integration

### Debug Mode

Enable debug logging by adding to `config.lua`:

```lua
Config.Debug = true
```

### Error Logging

Check server console for detailed error messages and vehicle usage logs.


### Development Guidelines
- Follow existing code style
- Add comments for complex logic
- Test thoroughly before submitting
- Update documentation for new features

## 📝 Changelog

### Version 1.2.0
- ✅ Added passenger-friendly vehicle restrictions
- ✅ Implemented gang-specific color themes
- ✅ Added silent speed limit enforcement
- ✅ Enhanced gang change detection
- ✅ Improved vehicle ownership tracking
- ✅ Removed notification spam

### Version 1.1.0
- ✅ Added gang-specific vehicle restrictions
- ✅ Implemented server-side validation
- ✅ Added automatic vehicle cleanup
- ✅ Enhanced security features
- ✅ Fixed variable declaration issues
- ✅ Added comprehensive error handling
- ✅ Implemented vehicle tracking system

### Version 1.0.0
- ✅ Initial release
- ✅ Basic gang vehicle system
- ✅ Vehicle spawning and storage
- ✅ Gang membership integration

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


**Made with ❤️ for the FiveM community** 
