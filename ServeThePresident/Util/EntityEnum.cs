using CitizenFX.Core;
using CitizenFX.Core.Native;
using System.Collections.Generic;

namespace ServeThePresident.Util
{
    class EntityEnum
    {
        /// <summary>
        /// Gets an <c>array</c> of all the <see cref="Prop"/>s on the map.
        /// </summary>
        public static Prop[] GetAllProps()
        {
            List<Prop> props = new List<Prop>();

            OutputArgument entHandleOut = new OutputArgument();
            int handle = Function.Call<int>(Hash.FIND_FIRST_OBJECT, entHandleOut);
            int entHandle = entHandleOut.GetResult<int>();

            Prop prop = (Prop) Entity.FromHandle(entHandle);
            if (prop != null)
                props.Add(prop);

            entHandleOut = new OutputArgument();
            while (Function.Call<bool>(Hash.FIND_NEXT_OBJECT, handle, entHandleOut))
            {
                entHandle = entHandleOut.GetResult<int>();
                prop = (Prop) Entity.FromHandle(entHandle);
                if (prop != null)
                    props.Add(prop);

                entHandleOut = new OutputArgument();
            }

            Function.Call(Hash.END_FIND_OBJECT, handle);
            return props.ToArray();
        }

        /// <summary>
        /// Gets an <c>array</c> of all the <see cref="Ped"/>s on the map.
        /// </summary>
        public static Ped[] GetAllPeds()
        {
            List<Ped> peds = new List<Ped>();

            OutputArgument entHandleOut = new OutputArgument();
            int handle = Function.Call<int>(Hash.FIND_FIRST_PED, entHandleOut);
            int entHandle = entHandleOut.GetResult<int>();

            Ped ped = (Ped) Entity.FromHandle(entHandle);
            if (ped != null)
                peds.Add(ped);

            entHandleOut = new OutputArgument();
            while (Function.Call<bool>(Hash.FIND_NEXT_PED, handle, entHandleOut))
            {
                entHandle = entHandleOut.GetResult<int>();
                ped = (Ped) Entity.FromHandle(entHandle);
                if (ped != null)
                    peds.Add(ped);

                entHandleOut = new OutputArgument();
            }

            Function.Call(Hash.END_FIND_PED, handle);
            return peds.ToArray();
        }

        /// <summary>
        /// Gets an <c>array</c> of all the <see cref="Vehicle"/>s on the map.
        /// </summary>
        public static Vehicle[] GetAllVehicles()
        {
            List<Vehicle> vehicles = new List<Vehicle>();

            OutputArgument entHandleOut = new OutputArgument();
            int handle = Function.Call<int>(Hash.FIND_FIRST_VEHICLE, entHandleOut);
            int entHandle = entHandleOut.GetResult<int>();

            Vehicle vehicle = (Vehicle) Entity.FromHandle(entHandle);
            if (vehicle != null)
                vehicles.Add(vehicle);

            entHandleOut = new OutputArgument();
            while (Function.Call<bool>(Hash.FIND_NEXT_VEHICLE, handle, entHandleOut))
            {
                entHandle = entHandleOut.GetResult<int>();
                vehicle = (Vehicle) Entity.FromHandle(entHandle);
                if (vehicle != null)
                    vehicles.Add(vehicle);

                entHandleOut = new OutputArgument();
            }

            Function.Call(Hash.END_FIND_VEHICLE, handle);
            return vehicles.ToArray();
        }

        /// <summary>
        /// Gets an <c>array</c> of all the <see cref="Pickup"/>s on the map.
        /// </summary>
        public static Pickup[] GetAllPickups()
        {
            List<Pickup> pickups = new List<Pickup>();

            OutputArgument entHandleOut = new OutputArgument();
            int handle = Function.Call<int>(Hash.FIND_FIRST_PICKUP, entHandleOut);
            int entHandle = entHandleOut.GetResult<int>();

            Pickup pickup = new Pickup(entHandle);
            if (pickup.Exists())
                pickups.Add(pickup);

            entHandleOut = new OutputArgument();
            while (Function.Call<bool>(Hash.FIND_NEXT_PICKUP, handle, entHandleOut))
            {
                entHandle = entHandleOut.GetResult<int>();
                pickup = new Pickup(entHandle);
                if (pickup.Exists())
                    pickups.Add(pickup);

                entHandleOut = new OutputArgument();
            }

            Function.Call(Hash.END_FIND_PICKUP, handle);
            return pickups.ToArray();
        }
    }
}
