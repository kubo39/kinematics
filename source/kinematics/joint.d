module kinematics.joint;

import std.exception;

class OutOfLimit : Exception
{
    mixin basicExceptionCtors;
}

struct MovableScope(T)
    if (__traits(isArithmetic, T))
{
    T min;
    T max;

    this(T min, T max) nothrow @nogc
    {
        this.min = min;
        this.max = max;
    }

    this() nothrow @nogc
    {
        this.min = T.min;
        this.max = T.max;
    }

    bool isValid(T angle) pure nothrow @nogc
    {
        return angle >= this.min && angle <= this.max;
    }
}

enum JointType
{
    Fixed,
    Rotational,
    Linear,
}

struct Joint(T)
    if (__traits(isArithmetic, T))
{
private:

    string name;
    JointType type;
    T angle;
    MovableScope!T limit;

public:

    this(string name, JointType type) nothrow
    {
        this.name = name;
        this.type = type;
        this.angle = 0;
        this.limit = MovableScope();
    }

    string name() @property nothrow @nogc
    {
        return this.name;
    }

    void limits(MovableScope!T limit) nothrow @nogc
    {
        this.limit = limit;
    }

    void angle(T angle) @property
    {
        if (this.type == JointType.Fixed)
            throw new OutOfLimit("Out of limit.");
        if (!this.limits.isValid(angle))
            throw new OutOfLimit("Out of limit.");
        this.angle = angle;
    }

    T angle() @property
    {
        switch (this.type)
        {
        case JointType.Fixed:
            break;
        default:
            return this.angle;
        }
        assert(false);
    }
}
