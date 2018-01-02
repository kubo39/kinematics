module kinematics.link;

import kinematics.joint;

struct Link(T)
{
    string name;
    Joint!T joint;

    this(string name, Joint!T joint) nothrow @nogc
    {
        this.name = name;
        this.joint = joint;
    }

    string jointName() @property pure nothrow @nogc
    {
        return this.joint.name;
    }

    T jointAngle() @property pure nothrow @nogc
    {
        return this.joint.angle;
    }
}
