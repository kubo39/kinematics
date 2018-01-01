module kinematics.euler;

import kinematics.core : Vector3;

struct Euler(T)
{
    Vector3!T coords;

    this(T roll, T pitch, T yaw) nothrow @nogc
    {
        this.coords.x = roll;
        this.coords.y = pitch;
        this.coords.z = yaw;
    }

    T roll() @property nothrow @nogc
    {
        return this.coords.x;
    }

    T pitch() @property nothrow @nogc
    {
        return this.coords.y;
    }

    T yaw() @property nothrow @nogc
    {
        return this.coords.z;
    }
}
