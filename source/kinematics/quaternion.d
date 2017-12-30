module kinematics.quaternion;

import std.algorithm : clamp;
import std.math : asin, atan2, cos, sin;

struct Vector3(T)
    if (__traits(isArithmetic, T))
{
    T x;
    T y;
    T z;
}

struct Vector4(T)
    if (__traits(isArithmetic, T))
{
    T x;
    T y;
    T z;
    T w;
}

struct Quaternion(T)
    if (__traits(isArithmetic, T))
{
    Vector4!T coords;

    // Create new quaternion from euler angles.
    this(T roll, T pitch, T yaw) nothrow @nogc
    {
        auto sr = sin(roll * 0.5);
        auto cr = cos(roll * 0.5);
        auto sp = sin(pitch * 0.5);
        auto cp = cos(pitch * 0.5);
        auto sy = sin(yaw * 0.5);
        auto cy = cos(yaw * 0.5);

        this.coords.x = sr * cp * cy - cr * sp * sy;
        this.coords.y = cr * sp * cy + sr * cp * sy;
        this.coords.z = cr * cp * sy - sr * sp * cy;
        this.coords.w = cr * cp * cy + sr * sp * sy;
    }

    // Ditto.
    this(Vector3!T rpy) nothrow @nogc
    {
        this(rpy.x, rpy.y, rpy.z);
    }

    T x() @property nothrow @nogc
    {
        return this.coords.x;
    }

    T y() @property nothrow @nogc
    {
        return this.coords.y;
    }

    T z() @property nothrow @nogc
    {
        return this.coords.z;
    }

    T w() @property nothrow @nogc
    {
        return this.coords.w;
    }

    // Create rpy angles.
    Vector3!T toEulerAngles() nothrow @nogc
    {
        auto ysqr = y * y;

        // roll.
        auto t0 = 2.0 * (w * x + y * z);
        auto t1 = 1.0 - 2.0 * (x * x + ysqr);
        auto roll = atan2(t0, t1);

        // pitch.
        auto t2 = 2.0 * (w * y - z * x);
        auto pitch = asin(clamp(-1.0, t2, 1.0));

        // yaw.
        auto t3 = 2.0 * (w * z + x * y);
        auto t4 = 1.0 - 2.0 * (ysqr + z * z);
        auto yaw = atan2(t3, t4);

        return Vector3!T(roll, pitch, yaw);
    }
}

unittest
{
    import std.math : abs, approxEqual;

    auto q = Quaternion!double(0.1, 0.2, 0.3);
    auto rpy = q.toEulerAngles();

    assert(approxEqual(rpy.x, 0.1));
    assert(approxEqual(rpy.y, 0.2));
    assert(approxEqual(rpy.z, 0.3));
}
