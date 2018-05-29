using CitizenFX.Core;
using CitizenFX.Core.Native;
using System;
using System.Collections.Generic;

namespace ServeThePresident.Util
{
    public enum DecorationType
    {
        Float = 1,
        Bool = 2,
        Int = 3,
        Time = 5
    }

    public static class EntityDecoration
    {
        internal static Type floatType = typeof(float);
        internal static Type boolType = typeof(bool);
        internal static Type intType = typeof(int);

        public static bool ExistOn(Entity entity, string propertyName)
        {
            return Function.Call<bool>(Hash.DECOR_EXIST_ON, entity.NativeValue, propertyName);
        }

        public static bool HasDecor(this Entity ent, string propertyName)
        {
            return ExistOn(ent, propertyName);
        }

        public static void RegisterProperty(string propertyName, DecorationType type)
        {
            Function.Call(Hash.DECOR_REGISTER, propertyName, (int)type);
        }

        public static void Set(Entity entity, string propertyName, float floatValue)
        {
            Function.Call(Hash._DECOR_SET_FLOAT, entity.NativeValue, propertyName, floatValue);
        }

        public static void Set(Entity entity, string propertyName, int intValue)
        {
            Function.Call(Hash.DECOR_SET_INT, entity.NativeValue, propertyName, intValue);
        }

        public static void Set(Entity entity, string propertyName, bool boolValue)
        {
            Function.Call(Hash.DECOR_SET_BOOL, entity.NativeValue, propertyName, boolValue);
        }

        public static void SetDecor(this Entity ent, string propertyName, float value)
        {
            Set(ent, propertyName, value);
        }

        public static void SetDecor(this Entity ent, string propertyName, int value)
        {
            Set(ent, propertyName, value);
        }

        public static void SetDecor(this Entity ent, string propertyName, bool value)
        {
            Set(ent, propertyName, value);
        }

        public static T Get<T>(Entity entity, string propertyName)
        {
            if (!ExistOn(entity, propertyName))
            {
                throw new EntityDecorationUnregisteredPropertyException();
            }

            Type genericType = typeof(T);
            Hash nativeMethod;

            if (genericType == floatType)
            {
                nativeMethod = Hash._DECOR_GET_FLOAT;
            }
            else if (genericType == intType)
            {
                nativeMethod = Hash.DECOR_GET_INT;
            }
            else if (genericType == boolType)
            {
                nativeMethod = Hash.DECOR_GET_BOOL;
            }
            else
            {
                throw new EntityDecorationUndefinedTypeException();
            }

            return (T)Function.Call<T>(nativeMethod, entity.NativeValue, propertyName);
        }

        public static T GetDecor<T>(this Entity ent, string propertyName)
        {
            return Get<T>(ent, propertyName);
        }
    }

    public class EntityDecorationUnregisteredPropertyException : Exception { }
    public class EntityDecorationUndefinedTypeException : Exception { }

    public static class EntityEnum
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

            Prop prop = (Prop)Entity.FromHandle(entHandle);
            if (prop != null)
                props.Add(prop);

            entHandleOut = new OutputArgument();
            while (Function.Call<bool>(Hash.FIND_NEXT_OBJECT, handle, entHandleOut))
            {
                entHandle = entHandleOut.GetResult<int>();
                prop = (Prop)Entity.FromHandle(entHandle);
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

            Ped ped = (Ped)Entity.FromHandle(entHandle);
            if (ped != null)
                peds.Add(ped);

            entHandleOut = new OutputArgument();
            while (Function.Call<bool>(Hash.FIND_NEXT_PED, handle, entHandleOut))
            {
                entHandle = entHandleOut.GetResult<int>();
                ped = (Ped)Entity.FromHandle(entHandle);
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

            Vehicle vehicle = (Vehicle)Entity.FromHandle(entHandle);
            if (vehicle != null)
                vehicles.Add(vehicle);

            entHandleOut = new OutputArgument();
            while (Function.Call<bool>(Hash.FIND_NEXT_VEHICLE, handle, entHandleOut))
            {
                entHandle = entHandleOut.GetResult<int>();
                vehicle = (Vehicle)Entity.FromHandle(entHandle);
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