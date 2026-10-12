"""Build the Pangalay Mirror low-poly avatar sources and GLB exports in Blender.

Run from the repository root:
  blender -b --python app-3d/tools/create_avatars.py
"""
from pathlib import Path
import bpy
from mathutils import Vector

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "app-3d" / "models"
OUT.mkdir(parents=True, exist_ok=True)


def clear_scene():
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)


def material(name, color, roughness=0.72, metallic=0.0):
    mat = bpy.data.materials.new(name)
    mat.diffuse_color = (*color, 1)
    mat.use_nodes = True
    shader = mat.node_tree.nodes.get("Principled BSDF")
    shader.inputs["Base Color"].default_value = (*color, 1)
    shader.inputs["Roughness"].default_value = roughness
    shader.inputs["Metallic"].default_value = metallic
    return mat


INK = material("Night outline", (0.035, 0.07, 0.09))
SKIN = material("Warm skin", (0.57, 0.31, 0.18))
GOLD = material("Gold details", (0.95, 0.63, 0.14), metallic=0.15)
NAVY = material("Boy navy", (0.055, 0.13, 0.20))
MAGENTA = material("Girl magenta", (0.58, 0.09, 0.29))
PURPLE = material("Deep purple", (0.20, 0.13, 0.31))
MAROON = material("Maroon", (0.40, 0.035, 0.11))
GREEN = material("Pis syabit green", (0.08, 0.42, 0.20))
ORANGE = material("Pis syabit orange", (0.92, 0.30, 0.06))
HAIR = material("Hair", (0.055, 0.045, 0.04))


def make_armature():
    bpy.ops.object.armature_add(enter_editmode=True, location=(0, 0, 0))
    rig = bpy.context.object
    rig.name = "PangalayRig"
    arm = rig.data
    root = arm.edit_bones[0]
    root.name = "root"
    root.head = (0, 0, 0.1)
    root.tail = (0, 0, 1.35)
    spine = arm.edit_bones.new("spine")
    spine.head, spine.tail, spine.parent = (0, 0, 1.35), (0, 0, 3.2), root
    neck = arm.edit_bones.new("neck")
    neck.head, neck.tail, neck.parent = (0, 0, 3.2), (0, 0, 3.5), spine
    head = arm.edit_bones.new("head")
    head.head, head.tail, head.parent = (0, 0, 3.5), (0, 0, 4.1), neck
    for side, x in (("L", -0.52), ("R", 0.52)):
        shoulder = arm.edit_bones.new(f"shoulder_{side}")
        shoulder.head, shoulder.tail, shoulder.parent = (x, 0, 3.12), (x, 0, 2.28), spine
        elbow = arm.edit_bones.new(f"elbow_{side}")
        elbow.head, elbow.tail, elbow.parent = (x, 0, 2.28), (x, 0, 1.52), shoulder
        wrist = arm.edit_bones.new(f"wrist_{side}")
        wrist.head, wrist.tail, wrist.parent = (x, 0, 1.52), (x, 0, 1.08), elbow
        # Set each bone's local Z axis toward the camera, so local Z rotation
        # moves its down-pointing segment left/right in the avatar plane.
        for bone in (shoulder, elbow, wrist):
            bone.align_roll(Vector((0, -1, 0)))
    bpy.ops.object.mode_set(mode="OBJECT")
    rig.show_in_front = True
    rig.display_type = "WIRE"
    return rig


PARTS = []


def finish_part(obj, name, bone, mat):
    obj.name = name
    obj.data.materials.clear()
    obj.data.materials.append(mat)
    vg = obj.vertex_groups.new(name=bone)
    vg.add(list(range(len(obj.data.vertices))), 1.0, "REPLACE")
    mod = obj.modifiers.new("PangalayRig", "ARMATURE")
    mod.object = RIG
    obj.parent = RIG
    PARTS.append(obj)
    return obj


def sphere(name, loc, scale, bone, mat, segments=16, rings=10):
    bpy.ops.mesh.primitive_uv_sphere_add(segments=segments, ring_count=rings, radius=1, location=loc)
    obj = bpy.context.object
    obj.scale = scale
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    for poly in obj.data.polygons:
        poly.use_smooth = True
    return finish_part(obj, name, bone, mat)


def cube(name, loc, scale, bone, mat, bevel=0.08):
    bpy.ops.mesh.primitive_cube_add(size=1, location=loc)
    obj = bpy.context.object
    obj.scale = scale
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    if bevel:
        mod = obj.modifiers.new("Soft edges", "BEVEL")
        mod.width = bevel
        mod.segments = 2
        bpy.context.view_layer.objects.active = obj
        bpy.ops.object.modifier_apply(modifier=mod.name)
    return finish_part(obj, name, bone, mat)


def cylinder(name, loc, radius, depth, bone, mat, vertices=12):
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices, radius=radius, depth=depth, location=loc)
    obj = bpy.context.object
    for poly in obj.data.polygons:
        poly.use_smooth = True
    return finish_part(obj, name, bone, mat)


def avatar(kind):
    global RIG, PARTS
    PARTS = []
    RIG = make_armature()
    shirt = MAGENTA if kind == "girl" else NAVY

    # Torso, neck, head and simple face stay deliberately close to the existing
    # vector-avatar palette and silhouette; no new cultural costume elements.
    sphere("Torso", (0, 0, 2.35), (0.57, 0.34, 0.98), "spine", shirt)
    cylinder("Neck", (0, 0, 3.34), 0.16, 0.38, "neck", SKIN)
    sphere("Head", (0, 0, 3.78), (0.39, 0.34, 0.42), "head", SKIN, 20, 12)
    sphere("Hair cap", (0, 0.005, 4.03), (0.40, 0.34, 0.19), "head", HAIR)
    # Simple eyes and smile, facing -Y (the camera side).
    for x in (-0.13, 0.13):
        sphere("Eye", (x, -0.324, 3.80), (0.035, 0.025, 0.035), "head", INK, 10, 6)
    sphere("Smile", (0, -0.327, 3.66), (0.075, 0.025, 0.025), "head", INK, 10, 6)

    # The girl uses a solid skirt; the boy uses separate trouser legs.
    if kind == "girl":
        cube("Skirt", (0, 0, 0.92), (1.08, 0.55, 1.38), "root", MAROON, 0.12)
        cube("Skirt band", (0, -0.286, 1.38), (1.02, 0.035, 0.11), "root", GREEN, 0.02)
        cube("Skirt hem", (0, -0.285, 0.37), (0.94, 0.035, 0.12), "root", ORANGE, 0.02)
        for x in (-0.25, 0.25):
            sphere("Shoe", (x, -0.02, 0.12), (0.26, 0.39, 0.14), "root", INK)
    else:
        for side, x in (("L", -0.27), ("R", 0.27)):
            cube(f"Trouser_{side}", (x, 0, 0.88), (0.42, 0.48, 1.48), "root", PURPLE, 0.08)
            sphere("Shoe", (x, -0.02, 0.12), (0.25, 0.39, 0.14), "root", INK)
        cube("Waist sash", (0, -0.005, 1.64), (1.12, 0.6, 0.18), "spine", MAROON, 0.03)
        cube("Sash detail", (-0.23, -0.31, 1.45), (0.16, 0.035, 0.56), "spine", ORANGE, 0.02)

    # Shirt detail: simple gold piping/buttons drawn from the existing palette.
    cube("Gold placket", (0, -0.346, 2.45), (0.055, 0.028, 1.22), "spine", GOLD, 0.015)
    for z in (1.98, 2.30, 2.62, 2.94):
        sphere("Button", (0.14, -0.365, z), (0.065, 0.035, 0.065), "spine", GOLD, 10, 6)

    for side, x in (("L", -0.52), ("R", 0.52)):
        # Rigidly weighted soft limb segments let the real bone rig control the arms.
        sphere(f"ShoulderPad_{side}", (x, 0, 3.05), (0.23, 0.27, 0.24), "spine", shirt)
        sphere(f"UpperArm_{side}", (x, 0, 2.69), (0.19, 0.22, 0.49), f"shoulder_{side}", shirt)
        sphere(f"ElbowJoint_{side}", (x, 0, 2.28), (0.19, 0.22, 0.20), f"shoulder_{side}", shirt)
        sphere(f"Forearm_{side}", (x, 0, 1.90), (0.16, 0.19, 0.47), f"elbow_{side}", shirt)
        sphere(f"WristJoint_{side}", (x, 0, 1.52), (0.15, 0.17, 0.16), f"elbow_{side}", SKIN)
        sphere(f"Hand_{side}", (x, 0, 1.28), (0.14, 0.18, 0.25), f"wrist_{side}", SKIN)
        if kind == "girl":
            for finger in (-1, 0, 1):
                sphere(f"Finger_{side}_{finger}", (x + finger * 0.07, -0.04, 1.06), (0.045, 0.07, 0.15), f"wrist_{side}", GOLD, 8, 6)

    # Select only rig and weighted meshes, then export one compact GLB.
    bpy.ops.object.select_all(action="DESELECT")
    RIG.select_set(True)
    bpy.context.view_layer.objects.active = RIG
    for obj in PARTS:
        obj.select_set(True)
    blend_path = OUT / f"avatar-{kind}.blend"
    bpy.ops.wm.save_as_mainfile(filepath=str(blend_path))
    glb_path = OUT / f"avatar-{kind}.glb"
    bpy.ops.export_scene.gltf(filepath=str(glb_path), export_format="GLB", use_selection=True,
                              export_apply=True, export_animations=False, export_skins=True,
                              export_yup=True, export_materials="EXPORT")
    print(f"Created {blend_path} ({blend_path.stat().st_size} bytes)")
    print(f"Created {glb_path} ({glb_path.stat().st_size} bytes)")


if __name__ == "__main__":
    bpy.context.preferences.filepaths.save_version = 0
    clear_scene()
    avatar("girl")
    clear_scene()
    avatar("boy")
