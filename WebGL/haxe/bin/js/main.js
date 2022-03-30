(function ($global) { "use strict";
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.remove = function(a,obj) {
	var i = a.indexOf(obj);
	if(i == -1) {
		return false;
	}
	a.splice(i,1);
	return true;
};
HxOverrides.now = function() {
	return Date.now();
};
var Main = function() {
	var _gthis = this;
	var engine = libs_webgl_Engine.inst();
	$(window).on("onAssetsLoaded",function(evt,assets) {
		engine.gl = assets.gl;
		var gl = assets.gl;
		var images = assets.images;
		var _g_current = 0;
		var _g_array = images;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var image = _g1_value;
			var t = libs_webgl_TextureTool.createTexture(gl,image);
			engine.pushTexture2D(t);
		}
		engine.addObjMeshs(assets.objs);
		var t = libs_webgl_TextureTool.createCubeMap(gl);
		engine.pushCubeTexture(t);
		t = libs_webgl_TextureTool.createCubeMapByURL(gl,512,512,"images/enviroment/001/pos-x.jpg","images/enviroment/001/neg-x.jpg","images/enviroment/001/pos-y.jpg","images/enviroment/001/neg-y.jpg","images/enviroment/001/pos-z.jpg","images/enviroment/001/neg-z.jpg");
		engine.pushCubeTexture(t);
		engine.init();
		_gthis.startApplication(engine);
	});
};
Main.__name__ = true;
Main.main = function() {
	new Main();
};
Main.prototype = {
	getColorFromString: function(colorStr) {
		var r = parseInt("0x" + colorStr.substring(1,3),16);
		var g = parseInt("0x" + colorStr.substring(3,5),16);
		var b = parseInt("0x" + colorStr.substring(5,7),16);
		return [r / 255.0,g / 255.0,b / 255.0];
	}
	,getStringFromColor: function(r,g,b) {
		var changeTo = ((r * 255 | 0) << 16) + ((g * 255 | 0) << 8) + (b * 255 | 0);
		var colorStr = "#" + StringTools.hex(changeTo,6);
		return colorStr;
	}
	,startApplication: function(engine) {
		var _gthis = this;
		var q = $;
		var div_light = q("#div_light");
		var div_meshRenderer = q("#div_meshRenderer");
		var div_camera = q("#div_camera");
		var div_lookAt = q("#div_lookAt");
		var div_circleMove = q("#div_circleMove");
		var hideAllEntityParameter = function() {
			div_light.hide();
			div_meshRenderer.hide();
			div_camera.hide();
			div_lookAt.hide();
			div_circleMove.hide();
		};
		var div_colorShader = q("#div_colorShader");
		var div_basicShader = q("#div_basicShader");
		var hideAllMaterialParameter = function() {
			div_colorShader.hide();
			div_basicShader.hide();
		};
		var col_light = q("#col_light");
		col_light.change(function(e) {
			var col = col_light.val();
			var rgb = _gthis.getColorFromString(col);
			engine.defaultLight.getComponent(libs_webgl_component_LightComponent).color[0] = rgb[0];
			engine.defaultLight.getComponent(libs_webgl_component_LightComponent).color[1] = rgb[1];
			engine.defaultLight.getComponent(libs_webgl_component_LightComponent).color[2] = rgb[2];
		});
		var spn_lightOuter = q("#spn_lightOuter");
		spn_lightOuter.slider({ onChange : function(n,o) {
			engine.defaultLight.getComponent(libs_webgl_component_LightComponent).limitOuter = n;
		}});
		var spn_lightInner = q("#spn_lightInner");
		spn_lightInner.slider({ onChange : function(n,o) {
			engine.defaultLight.getComponent(libs_webgl_component_LightComponent).limitInner = n;
		}});
		var col_outlineColor = q("#col_outlineColor");
		col_outlineColor.change(function(e) {
			var col = col_outlineColor.val();
			var rgb = _gthis.getColorFromString(col);
			engine.outlineMaterial.uniforms[0][1] = rgb;
		});
		var spn_outlineThickness = q("#spn_outlineThickness");
		spn_outlineThickness.slider({ onChange : function(n,o) {
			engine.outlineMaterial.uniforms[1][1] = n;
		}});
		var c = engine.outlineMaterial.uniforms[0][1];
		var changeTo = this.getStringFromColor(c[0],c[1],c[2]);
		col_outlineColor.val(changeTo);
		var t = engine.outlineMaterial.uniforms[1][1];
		spn_outlineThickness.slider("setValue",t);
		var tree_actors = q("#tree_actors");
		var tree_mats = q("#tree_mats");
		var selMesh = q("#selMesh");
		var btnAdd = q("#btnAdd");
		var btn_addMaterial = q("#btn_addMaterial");
		var lbl_materialName = q("#lbl_materialName");
		var nodeName = q("#nodeName");
		var posx = q("#posx");
		var posy = q("#posy");
		var posz = q("#posz");
		var rotx = q("#rotx");
		var roty = q("#roty");
		var rotz = q("#rotz");
		var scax = q("#scax");
		var scay = q("#scay");
		var scaz = q("#scaz");
		var sel_setMesh = q("#sel_setMesh");
		var sel_setMaterial = q("#sel_setMaterial");
		var sel_lookAtActor = q("#sel_lookAtActor");
		var sel_shader = q("#sel_shader");
		var col_diffuse = q("#col_diffuse");
		var col_specular = q("#col_specular");
		var spn_gloss = q("#spn_gloss");
		var col_diffuse1 = q("#col_diffuse1");
		var col_specular1 = q("#col_specular1");
		var spn_gloss1 = q("#spn_gloss1");
		var spn_bump1 = q("#spn_bump1");
		var spn_fov = q("#spn_fov");
		var spn_near = q("#spn_near");
		var spn_far = q("#spn_far");
		var spn_circleSpeed = q("#spn_circleSpeed");
		var spn_circleRange = q("#spn_circleRange");
		var updateActorParameter = function(node) {
			nodeName.html(node.name);
			if(node.name != engine.defaultCamera.name) {
				posx.numberspinner("setValue",node.transform.position[0]);
				posy.numberspinner("setValue",node.transform.position[1]);
				posz.numberspinner("setValue",node.transform.position[2]);
				rotx.numberspinner("setValue",node.transform.rotation[0]);
				roty.numberspinner("setValue",node.transform.rotation[1]);
				rotz.numberspinner("setValue",node.transform.rotation[2]);
				scax.numberspinner("setValue",node.transform.scale[0]);
				scay.numberspinner("setValue",node.transform.scale[1]);
				scaz.numberspinner("setValue",node.transform.scale[2]);
			}
			hideAllEntityParameter();
			var comps = node.getComponents();
			var _g_current = 0;
			var _g_array = comps;
			while(_g_current < _g_array.length) {
				var _g1_value = _g_array[_g_current];
				var _g1_key = _g_current++;
				var index = _g1_key;
				var value = _g1_value;
				switch(js_Boot.getClass(value)) {
				case libs_webgl_component_CameraComponent:
					div_camera.show();
					var cameraComp = node.getComponent(libs_webgl_component_CameraComponent);
					spn_fov.slider("setValue",cameraComp.fieldOfView);
					spn_near.slider("setValue",cameraComp.near);
					spn_far.slider("setValue",cameraComp.far);
					break;
				case libs_webgl_component_CircleMoveComponent:
					div_circleMove.show();
					var circle = node.getComponent(libs_webgl_component_CircleMoveComponent);
					spn_circleSpeed.slider("setValue",circle.speed);
					spn_circleRange.slider("setValue",circle.range);
					break;
				case libs_webgl_component_LightComponent:
					div_light.show();
					break;
				case libs_webgl_component_LookAtComponent:
					div_lookAt.show();
					var lookAt = node.getComponent(libs_webgl_component_LookAtComponent).target;
					if(lookAt != null) {
						var nodes = engine.getNodes();
						var id = nodes.indexOf(lookAt);
						sel_lookAtActor.combobox("setValue",id);
					}
					break;
				case libs_webgl_component_MeshRenderComponent:
					div_meshRenderer.show();
					var meshComp = node.getComponent(libs_webgl_component_MeshRenderComponent);
					var mesh = meshComp.mesh;
					if(js_Boot.getClass(mesh) == libs_webgl_mesh_ObjMesh) {
						var temp = js_Boot.__cast(mesh , libs_webgl_mesh_ObjMesh);
						var meshId = engine.objMeshs.indexOf(temp);
						sel_setMesh.combobox("setValue",meshId);
					}
					var material = meshComp.material;
					var materialId = engine.materials.indexOf(material);
					sel_setMaterial.combobox("setValue",materialId);
					break;
				}
			}
		};
		var updateMaterialParameter = function(mat) {
			lbl_materialName.html(mat.name);
			var shaderId = engine.shaders.indexOf(mat.shader);
			sel_shader.combobox("setValue",shaderId);
			hideAllMaterialParameter();
			switch(js_Boot.getClass(mat.shader)) {
			case libs_webgl_material_shader_BasicShader:
				div_basicShader.show();
				var c = mat.uniforms[0][1];
				var changeTo = _gthis.getStringFromColor(c[0],c[1],c[2]);
				col_diffuse1.val(changeTo);
				c = mat.uniforms[1][1];
				changeTo = _gthis.getStringFromColor(c[0],c[1],c[2]);
				col_specular1.val(changeTo);
				var gloss = mat.uniforms[2][1];
				spn_gloss1.slider("setValue",gloss);
				var bump = mat.uniforms[3][1];
				spn_bump1.slider("setValue",bump);
				break;
			case libs_webgl_material_shader_ColorShader:
				div_colorShader.show();
				var c = mat.uniforms[0][1];
				var changeTo = _gthis.getStringFromColor(c[0],c[1],c[2]);
				col_diffuse.val(changeTo);
				c = mat.uniforms[1][1];
				changeTo = _gthis.getStringFromColor(c[0],c[1],c[2]);
				col_specular.val(changeTo);
				var gloss = mat.uniforms[2][1];
				spn_gloss.slider("setValue",gloss);
				break;
			}
		};
		var currentNode = null;
		var currentMaterial = null;
		col_diffuse.change(function(e) {
			if(currentMaterial != null) {
				var col = col_diffuse.val();
				var rgb = _gthis.getColorFromString(col);
				currentMaterial.uniforms[0][1] = rgb;
			}
		});
		col_specular.change(function(e) {
			if(currentMaterial != null) {
				var col = col_specular.val();
				var rgb = _gthis.getColorFromString(col);
				currentMaterial.uniforms[1][1] = rgb;
			}
		});
		spn_gloss.slider({ onChange : function(n,o) {
			if(currentMaterial != null) {
				currentMaterial.uniforms[2][1] = n;
			}
		}});
		col_diffuse1.change(function(e) {
			if(currentMaterial != null) {
				var col = col_diffuse1.val();
				var rgb = _gthis.getColorFromString(col);
				currentMaterial.uniforms[0][1] = rgb;
			}
		});
		col_specular1.change(function(e) {
			if(currentMaterial != null) {
				var col = col_specular1.val();
				var rgb = _gthis.getColorFromString(col);
				currentMaterial.uniforms[1][1] = rgb;
			}
		});
		spn_gloss1.slider({ onChange : function(n,o) {
			if(currentMaterial != null) {
				currentMaterial.uniforms[2][1] = n;
			}
		}});
		spn_bump1.slider({ onChange : function(n,o) {
			if(currentMaterial != null) {
				currentMaterial.uniforms[3][1] = n;
			}
		}});
		sel_shader.combobox({ onChange : function() {
			if(currentMaterial != null) {
				var shaderId = sel_shader.combobox("getValue");
				currentMaterial.shader = engine.shaders[shaderId];
				updateMaterialParameter(currentMaterial);
			}
		}});
		sel_setMesh.combobox({ onChange : function() {
			if(currentNode != null) {
				var meshId = sel_setMesh.combobox("getValue");
				currentNode.getComponent(libs_webgl_component_MeshRenderComponent).mesh = engine.objMeshs[meshId];
			}
		}});
		sel_setMaterial.combobox({ onChange : function() {
			if(currentNode != null) {
				var oldMaterial = currentNode.getComponent(libs_webgl_component_MeshRenderComponent).material;
				if(oldMaterial != null) {
					oldMaterial.removeNode(currentNode);
				}
				var matId = sel_setMaterial.combobox("getValue");
				var material = engine.materials[matId];
				if(material != null) {
					material.pushNode(currentNode);
				}
			}
		}});
		sel_lookAtActor.combobox({ onChange : function() {
			if(currentNode != null) {
				var id = sel_lookAtActor.combobox("getValue");
				var actor = engine.getNodes()[id];
				currentNode.getComponent(libs_webgl_component_LookAtComponent).target = actor;
			}
		}});
		spn_fov.slider({ onChange : function(n,o) {
			if(currentNode != null) {
				currentNode.getComponent(libs_webgl_component_CameraComponent).fieldOfView = n;
			}
		}});
		spn_near.slider({ onChange : function(n,o) {
			if(currentNode != null) {
				currentNode.getComponent(libs_webgl_component_CameraComponent).near = n;
			}
		}});
		spn_far.slider({ onChange : function(n,o) {
			if(currentNode != null) {
				currentNode.getComponent(libs_webgl_component_CameraComponent).far = n;
			}
		}});
		spn_circleSpeed.slider({ onChange : function(n,o) {
			if(currentNode != null) {
				currentNode.getComponent(libs_webgl_component_CircleMoveComponent).speed = n;
			}
		}});
		spn_circleRange.slider({ onChange : function(n,o) {
			if(currentNode != null) {
				currentNode.getComponent(libs_webgl_component_CircleMoveComponent).range = n;
			}
		}});
		var onPosXChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.position[0] = newValue;
			}
		};
		var onPosYChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.position[1] = newValue;
			}
		};
		var onPosZChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.position[2] = newValue;
			}
		};
		var onRotXChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.rotation[0] = newValue;
			}
		};
		var onRotYChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.rotation[1] = newValue;
			}
		};
		var onRotZChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.rotation[2] = newValue;
			}
		};
		var onScaleXChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.scale[0] = newValue;
			}
		};
		var onScaleYChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.scale[1] = newValue;
			}
		};
		var onScaleZChange = function(newValue,oldValue) {
			if(currentNode != null) {
				currentNode.transform.scale[2] = newValue;
			}
		};
		posx.numberspinner({ onChange : onPosXChange});
		posy.numberspinner({ onChange : onPosYChange});
		posz.numberspinner({ onChange : onPosZChange});
		rotx.numberspinner({ onChange : onRotXChange});
		roty.numberspinner({ onChange : onRotYChange});
		rotz.numberspinner({ onChange : onRotZChange});
		scax.numberspinner({ onChange : onScaleXChange});
		scay.numberspinner({ onChange : onScaleYChange});
		scaz.numberspinner({ onChange : onScaleZChange});
		tree_actors.tree({ onClick : function(item) {
			currentNode = item.node;
			engine.outlineMaterial.clearNodes();
			engine.outlineMaterial.pushNode(currentNode);
			updateActorParameter(currentNode);
		}});
		tree_mats.tree({ onClick : function(item) {
			currentMaterial = item.material;
			updateMaterialParameter(item.material);
		}});
		var updateTree = function() {
			var nodes = engine.getNodes();
			var data = [{ text : "DefaultCamera", node : engine.defaultCamera},{ text : "DefaultLight", node : engine.defaultLight}];
			var _g_current = 0;
			var _g_array = nodes;
			while(_g_current < _g_array.length) {
				var _g1_value = _g_array[_g_current];
				var _g1_key = _g_current++;
				var index = _g1_key;
				var node = _g1_value;
				data.push({ text : node.name, node : node});
			}
			tree_actors.tree({ data : data});
		};
		var updateMaterialTree = function() {
			var materials = engine.materials;
			var data = [];
			var _g_current = 0;
			var _g_array = materials;
			while(_g_current < _g_array.length) {
				var _g1_value = _g_array[_g_current];
				var _g1_key = _g_current++;
				var index = _g1_key;
				var material = _g1_value;
				data.push({ text : material.name, material : material});
			}
			tree_mats.tree({ data : data});
		};
		var updateCombobox = function(combo,infos,cb) {
			var info = [];
			var _g_current = 0;
			var _g_array = infos;
			while(_g_current < _g_array.length) {
				var _g1_value = _g_array[_g_current];
				var _g1_key = _g_current++;
				var index = _g1_key;
				var value = _g1_value;
				info.push({ label : value.name, value : index});
			}
			combo.combobox({ valueField : "value", textField : "label", data : info});
			if(cb != null) {
				cb();
			}
		};
		var createNode = function(name,meshId,materialId) {
			if(materialId == null) {
				materialId = 0;
			}
			if(meshId == null) {
				meshId = 0;
			}
			if(name == null) {
				name = "";
			}
			var node = new libs_webgl_actor_MeshActor(name);
			node.getComponent(libs_webgl_component_MeshRenderComponent).mesh = engine.objMeshs[meshId];
			if(materialId >= 0) {
				engine.materials[materialId].pushNode(node);
			}
			engine.solidMaterial.pushNode(node);
			updateTree();
			updateCombobox(sel_lookAtActor,engine.getNodes());
			return node;
		};
		btnAdd.bind("click",function(e) {
			var meshId = selMesh.combobox("getValue");
			createNode("node_" + new Date().getTime(),meshId,0);
		});
		var createMaterial = function(name,shaderId) {
			if(shaderId == null) {
				shaderId = 0;
			}
			if(name == null) {
				name = "";
			}
			var n = name == "" ? "Material_" + new Date().getTime() : name;
			var mat = new libs_webgl_material_Material(engine.shaders[shaderId],n);
			mat.pushTexture("u_diffuseMap",engine.textures[0],engine.gl.TEXTURE_2D);
			mat.pushTexture("u_normalMap",engine.textures[1],engine.gl.TEXTURE_2D);
			mat.pushTexture("u_depthMap",engine.depthTexture,engine.gl.TEXTURE_2D);
			mat.pushUniform("u_diffuseColor",[1.,1.,1.]);
			mat.pushUniform("u_specColor",[1.,1.,1.]);
			mat.pushUniform("u_gloss",90);
			mat.pushUniform("u_bump",1.0);
			engine.addMaterial(mat);
			updateMaterialTree();
			updateCombobox(sel_setMaterial,engine.materials,function() {
				if(currentNode != null) {
					updateActorParameter(currentNode);
				}
			});
			return mat;
		};
		btn_addMaterial.bind("click",function(e) {
			createMaterial();
		});
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var upForce = this2;
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var leftForce = this2;
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var downForce = this2;
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var rightForce = this2;
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var forwardForce = this2;
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var backwardForce = this2;
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var totalForce = this2;
		var defaultCamera = engine.defaultCamera;
		var document = window.document;
		var isMouseDown = false;
		document.addEventListener("keydown",function(event) {
			if(!isMouseDown) {
				return;
			}
			switch(event.keyCode) {
			case 65:
				leftForce = mme_math_glmatrix_Vec3Tools.scale(defaultCamera.transform.getBackward(),.1);
				break;
			case 68:
				rightForce = mme_math_glmatrix_Vec3Tools.scale(defaultCamera.transform.getForward(),.1);
				break;
			case 69:
				upForce = mme_math_glmatrix_Vec3Tools.scale(defaultCamera.transform.getUp(),.1);
				break;
			case 81:
				downForce = mme_math_glmatrix_Vec3Tools.scale(defaultCamera.transform.getDown(),.1);
				break;
			case 83:
				backwardForce = mme_math_glmatrix_Vec3Tools.scale(defaultCamera.transform.getRight(),.1);
				break;
			case 87:
				forwardForce = mme_math_glmatrix_Vec3Tools.scale(defaultCamera.transform.getLeft(),.1);
				break;
			}
		});
		document.addEventListener("keyup",function(event) {
			switch(event.keyCode) {
			case 65:
				mme_math_glmatrix_Vec3Tools.zero(leftForce);
				break;
			case 68:
				mme_math_glmatrix_Vec3Tools.zero(rightForce);
				break;
			case 69:
				mme_math_glmatrix_Vec3Tools.zero(upForce);
				break;
			case 81:
				mme_math_glmatrix_Vec3Tools.zero(downForce);
				break;
			case 83:
				mme_math_glmatrix_Vec3Tools.zero(backwardForce);
				break;
			case 87:
				mme_math_glmatrix_Vec3Tools.zero(forwardForce);
				break;
			}
		});
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var clickPos = this2;
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var currentRot = this2;
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var currentQuat = this2;
		document.addEventListener("mousedown",function(event) {
			if(event.button == 0) {
				currentRot = mme_math_glmatrix_Vec3Tools.clone(defaultCamera.transform.rotation);
				clickPos[0] = event.offsetX;
				clickPos[1] = event.offsetY;
				isMouseDown = true;
			}
		});
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var rotForce = this2;
		document.addEventListener("mousemove",function(event) {
			if(isMouseDown) {
				if(event.button == 0) {
					var xOffset = event.offsetX - clickPos[0];
					var yOffset = event.offsetY - clickPos[1];
					rotForce[0] = yOffset * -.1;
					rotForce[1] = xOffset * -.1;
					mme_math_glmatrix_Vec3Tools.add(rotForce,currentRot,rotForce);
					defaultCamera.transform.rotation = mme_math_glmatrix_Vec3Tools.clone(rotForce);
				}
			}
		});
		document.addEventListener("mouseup",function(event) {
			if(event.button == 0) {
				isMouseDown = false;
				mme_math_glmatrix_Vec3Tools.zero(rotForce);
			}
		});
		engine.setSkyboxTexture(1);
		var normalMapMaterial = createMaterial("NormalMapMaterial",1);
		normalMapMaterial.pushTexture("u_diffuseMap",engine.textures[0],engine.gl.TEXTURE_2D);
		normalMapMaterial.pushTexture("u_normalMap",engine.textures[1],engine.gl.TEXTURE_2D);
		var colorMapMaterial = createMaterial("ColorMapMaterial",0);
		var cubeMapMateral = createMaterial("CubeMapMaterial",2);
		cubeMapMateral.pushTexture("u_texture",engine.cubeTextures[0],engine.gl.TEXTURE_CUBE_MAP);
		var enviromentMapMaterial = createMaterial("EnviromentMapMaterial",3);
		enviromentMapMaterial.pushTexture("u_texture",engine.cubeTextures[1],engine.gl.TEXTURE_CUBE_MAP);
		var lightTarget = createNode("DefaultLightTarget",0,0);
		var y = lightTarget.transform.scale[2] = .1;
		var x = lightTarget.transform.scale[1] = y;
		lightTarget.transform.scale[0] = x;
		var lookAtComp = new libs_webgl_component_LookAtComponent();
		lookAtComp.target = lightTarget;
		engine.defaultLight.addComponent(lookAtComp);
		var showList = [["ExNormalMap",1,0],["ExColorMap",1,1],["ExCubeMap",1,2],["ExEnviromentMap",0,3]];
		var _g_current = 0;
		var _g_array = showList;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			var name = value[0];
			var meshId = value[1];
			var materialId = value[2];
			var actor = createNode(name,meshId,materialId);
			actor.transform.position[0] = index * 2.5;
		}
		var table = createNode("ExTable",0,0);
		table.transform.position[1] = -2;
		var x = table.transform.scale[2] = 20;
		table.transform.scale[0] = x;
		table.transform.scale[1] = .1;
		hideAllEntityParameter();
		hideAllMaterialParameter();
		var animate = null;
		animate = function(time) {
			mme_math_glmatrix_Vec3Tools.zero(totalForce);
			mme_math_glmatrix_Vec3Tools.add(totalForce,upForce,totalForce);
			mme_math_glmatrix_Vec3Tools.add(totalForce,downForce,totalForce);
			mme_math_glmatrix_Vec3Tools.add(totalForce,leftForce,totalForce);
			mme_math_glmatrix_Vec3Tools.add(totalForce,rightForce,totalForce);
			mme_math_glmatrix_Vec3Tools.add(totalForce,forwardForce,totalForce);
			mme_math_glmatrix_Vec3Tools.add(totalForce,backwardForce,totalForce);
			defaultCamera.getComponent(libs_webgl_component_ParticleComponent).applyForce(totalForce);
			engine.render(time);
			window.requestAnimationFrame(animate);
		};
		animate(0);
	}
	,__class__: Main
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( _g ) {
		return null;
	}
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.hex = function(n,digits) {
	var s = "";
	var hexChars = "0123456789ABCDEF";
	while(true) {
		s = hexChars.charAt(n & 15) + s;
		n >>>= 4;
		if(!(n > 0)) {
			break;
		}
	}
	if(digits != null) {
		while(s.length < digits) s = "0" + s;
	}
	return s;
};
var haxe_Exception = function(message,previous,native) {
	Error.call(this,message);
	this.message = message;
	this.__previousException = previous;
	this.__nativeException = native != null ? native : this;
};
haxe_Exception.__name__ = true;
haxe_Exception.thrown = function(value) {
	if(((value) instanceof haxe_Exception)) {
		return value.get_native();
	} else if(((value) instanceof Error)) {
		return value;
	} else {
		var e = new haxe_ValueException(value);
		return e;
	}
};
haxe_Exception.__super__ = Error;
haxe_Exception.prototype = $extend(Error.prototype,{
	get_native: function() {
		return this.__nativeException;
	}
	,__class__: haxe_Exception
});
var haxe_ValueException = function(value,previous,native) {
	haxe_Exception.call(this,String(value),previous,native);
	this.value = value;
};
haxe_ValueException.__name__ = true;
haxe_ValueException.__super__ = haxe_Exception;
haxe_ValueException.prototype = $extend(haxe_Exception.prototype,{
	__class__: haxe_ValueException
});
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.__name__ = true;
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
	,__class__: haxe_iterators_ArrayIterator
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.getClass = function(o) {
	if(o == null) {
		return null;
	} else if(((o) instanceof Array)) {
		return Array;
	} else {
		var cl = o.__class__;
		if(cl != null) {
			return cl;
		}
		var name = js_Boot.__nativeClassName(o);
		if(name != null) {
			return js_Boot.__resolveNativeClass(name);
		}
		return null;
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g = 0;
			var _g1 = o.length;
			while(_g < _g1) {
				var i = _g++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( _g ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) {
			str += ", \n";
		}
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "string":
		return o;
	default:
		return String(o);
	}
};
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) {
		return false;
	}
	if(cc == cl) {
		return true;
	}
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g = 0;
		var _g1 = intf.length;
		while(_g < _g1) {
			var i = _g++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) {
				return true;
			}
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) {
		return false;
	}
	switch(cl) {
	case Array:
		return ((o) instanceof Array);
	case Bool:
		return typeof(o) == "boolean";
	case Dynamic:
		return o != null;
	case Float:
		return typeof(o) == "number";
	case Int:
		if(typeof(o) == "number") {
			return ((o | 0) === o);
		} else {
			return false;
		}
		break;
	case String:
		return typeof(o) == "string";
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(js_Boot.__downcastCheck(o,cl)) {
					return true;
				}
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(((o) instanceof cl)) {
					return true;
				}
			}
		} else {
			return false;
		}
		if(cl == Class ? o.__name__ != null : false) {
			return true;
		}
		if(cl == Enum ? o.__ename__ != null : false) {
			return true;
		}
		return false;
	}
};
js_Boot.__downcastCheck = function(o,cl) {
	if(!((o) instanceof cl)) {
		if(cl.__isInterface__) {
			return js_Boot.__interfLoop(js_Boot.getClass(o),cl);
		} else {
			return false;
		}
	} else {
		return true;
	}
};
js_Boot.__cast = function(o,t) {
	if(o == null || js_Boot.__instanceof(o,t)) {
		return o;
	} else {
		throw haxe_Exception.thrown("Cannot cast " + Std.string(o) + " to " + Std.string(t));
	}
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") {
		return null;
	}
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return $global[name];
};
var libs_webgl_AObject = function(name) {
	this.name = name != null ? name : "";
};
libs_webgl_AObject.__name__ = true;
libs_webgl_AObject.prototype = {
	__class__: libs_webgl_AObject
};
var libs_webgl_Engine = function() {
	this.materials = [];
	this.objMeshs = [];
	this.cubeTextures = [];
	this.textures = [];
	this.shaders = [];
};
libs_webgl_Engine.__name__ = true;
libs_webgl_Engine.inst = function() {
	return libs_webgl_Engine._inst;
};
libs_webgl_Engine.prototype = {
	init: function() {
		this.shaders.push(new libs_webgl_material_shader_ColorShader());
		this.shaders.push(new libs_webgl_material_shader_BasicShader());
		this.shaders.push(new libs_webgl_material_shader_CubeMapShader());
		this.shaders.push(new libs_webgl_material_shader_EnviromentMapShader());
		this.defaultCamera = new libs_webgl_actor_CameraActor("DefaultCamera");
		this.defaultCamera.transform.position[2] = 10;
		this.defaultCamera.getComponent(libs_webgl_component_CameraComponent).canvasWidth = this.gl.canvas.clientWidth;
		this.defaultCamera.getComponent(libs_webgl_component_CameraComponent).canvasHeight = this.gl.canvas.clientHeight;
		this.defaultLight = new libs_webgl_actor_LightActor("DefaultLight");
		this.defaultLight.transform.position[0] = 0;
		this.defaultLight.transform.position[1] = 7;
		this.defaultLight.transform.position[2] = 10;
		var cmc = new libs_webgl_component_CircleMoveComponent();
		cmc.speed = .5;
		cmc.range = 10;
		this.defaultLight.addComponent(cmc);
		this.outlineMaterial = new libs_webgl_material_Material(new libs_webgl_material_shader_OutlineShader());
		this.outlineMaterial.pushUniform("u_color",[1.,1.,0.]);
		this.outlineMaterial.pushUniform("u_thickness",.2);
		this.outlineMaterial.autoAssignToMeshRender = false;
		this.solidMaterial = new libs_webgl_material_Material(new libs_webgl_material_shader_SolidColorShader());
		this.solidMaterial.pushUniform("u_color",[1.,1.,1.]);
		this.solidMaterial.autoAssignToMeshRender = false;
		this.solidMaterial.pushNode(this.defaultLight);
		this.createDepthBuffer();
		this.depthMaterial = new libs_webgl_material_Material(new libs_webgl_material_shader_OnlyTextureShader());
		this.depthMaterial.pushTexture("u_texture",this.depthTexture,this.gl.TEXTURE_2D);
		this.depthMaterial.autoAssignToMeshRender = false;
		var depth = new libs_webgl_actor_MeshActor("DepthPass");
		depth.getComponent(libs_webgl_component_MeshRenderComponent).mesh = new libs_webgl_mesh_PlaneMesh();
		depth.transform.position[0] = 1;
		depth.transform.position[1] = 3;
		depth.transform.rotation[0] = 90;
		depth.transform.set_parent(this.defaultCamera.transform);
		this.depthMaterial.pushNode(depth);
	}
	,setSkyboxTexture: function(textureId) {
		if(this.skyboxMaterial == null) {
			this.skyboxMaterial = new libs_webgl_material_Material(new libs_webgl_material_shader_SkyboxShader());
			var skybox = new libs_webgl_actor_MeshActor("Skybox");
			skybox.getComponent(libs_webgl_component_MeshRenderComponent).mesh = new libs_webgl_mesh_QuadMesh();
			this.skyboxMaterial.pushNode(skybox);
		}
		this.skyboxMaterial.clearTextures();
		this.skyboxMaterial.pushTexture("u_texture",this.cubeTextures[textureId],this.gl.TEXTURE_CUBE_MAP);
	}
	,getShader: function(clz) {
		var ret = null;
		var _g_current = 0;
		var _g_array = this.shaders;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			if(js_Boot.__instanceof(value,clz)) {
				ret = value;
				break;
			}
		}
		return ret;
	}
	,createDepthBuffer: function() {
		this.depthTexture = libs_webgl_TextureTool.createDepthTexture(this.gl,512,512);
		this.depthFramebuffer = this.gl.createFramebuffer();
		this.gl.bindFramebuffer(this.gl.FRAMEBUFFER,this.depthFramebuffer);
		this.gl.framebufferTexture2D(this.gl.FRAMEBUFFER,this.gl.DEPTH_ATTACHMENT,this.gl.TEXTURE_2D,this.depthTexture,0);
		this.gl.bindFramebuffer(this.gl.FRAMEBUFFER,null);
	}
	,pushCubeTexture: function(t) {
		this.cubeTextures.push(t);
	}
	,pushTexture2D: function(t) {
		this.textures.push(t);
	}
	,addMaterials: function(materials) {
		this.materials = this.materials.concat(materials);
	}
	,addMaterial: function(material) {
		this.materials.push(material);
	}
	,addObjMesh: function(mesh) {
		this.objMeshs.push(new libs_webgl_mesh_ObjMesh(mesh));
	}
	,addObjMeshs: function(meshs) {
		var _g_current = 0;
		var _g_array = meshs;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			this.addObjMesh(value);
		}
	}
	,renderMaterial: function(material,view) {
		var program = material.shader.program;
		this.gl.useProgram(program);
		material.glSetTextureAndUniform();
		var usingView = view != null ? view : this.defaultCamera;
		this.gl.uniform3fv(Reflect.field(material.shader.uniformKey,"u_lightColor"),mme_math_glmatrix_Vec3.toArray(this.defaultLight.getComponent(libs_webgl_component_LightComponent).color));
		this.gl.uniform3fv(Reflect.field(material.shader.uniformKey,"u_specularColor"),[1,1,1]);
		this.gl.uniform3fv(Reflect.field(material.shader.uniformKey,"u_viewWorldPos"),mme_math_glmatrix_Vec3.toArray(usingView.transform.position));
		this.gl.uniform3fv(Reflect.field(material.shader.uniformKey,"u_lightWorldPos"),mme_math_glmatrix_Vec3.toArray(this.defaultLight.transform.position));
		this.gl.uniform3fv(Reflect.field(material.shader.uniformKey,"u_lightWorldDirection"),mme_math_glmatrix_Vec3.toArray(this.defaultLight.transform.getLeft()));
		this.gl.uniform1f(Reflect.field(material.shader.uniformKey,"u_lightOuter"),this.defaultLight.getComponent(libs_webgl_component_LightComponent).limitOuter);
		this.gl.uniform1f(Reflect.field(material.shader.uniformKey,"u_lightInner"),this.defaultLight.getComponent(libs_webgl_component_LightComponent).limitInner);
		this.gl.uniformMatrix4fv(Reflect.field(material.shader.uniformKey,"u_viewMat"),false,mme_math_glmatrix_Mat4.toArray(usingView.transform.getMatrix()));
		this.gl.uniformMatrix4fv(Reflect.field(material.shader.uniformKey,"u_projectMat"),false,mme_math_glmatrix_Mat4.toArray(usingView.getComponent(libs_webgl_component_CameraComponent).getProjectMatrix()));
		this.gl.uniformMatrix4fv(Reflect.field(material.shader.uniformKey,"u_lightViewMat"),false,mme_math_glmatrix_Mat4.toArray(this.defaultLight.transform.getMatrix()));
		this.gl.uniformMatrix4fv(Reflect.field(material.shader.uniformKey,"u_lightProjectMat"),false,mme_math_glmatrix_Mat4.toArray(this.defaultLight.getComponent(libs_webgl_component_CameraComponent).getProjectMatrix()));
		var nodes = material.nodes;
		var _g_current = 0;
		var _g_array = nodes;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var node = _g1_value;
			var meshRender = node.getComponent(libs_webgl_component_MeshRenderComponent);
			var vao = meshRender.mesh.vao;
			this.gl.bindVertexArray(vao);
			this.gl.uniformMatrix4fv(Reflect.field(material.shader.uniformKey,"u_modelMat"),false,mme_math_glmatrix_Mat4.toArray(node.transform.getMatrix()));
			this.gl.drawArrays(this.gl.TRIANGLES,0,meshRender.mesh.getCount());
		}
	}
	,render: function(time,px,py) {
		if(py == null) {
			py = 0;
		}
		if(px == null) {
			px = 0;
		}
		var nodes = this.getNodes();
		var _g_current = 0;
		var _g_array = nodes;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			value.update(time);
		}
		this.defaultCamera.update(time);
		this.defaultLight.update(time);
		this.gl.bindFramebuffer(this.gl.FRAMEBUFFER,this.depthFramebuffer);
		this.gl.viewport(0,0,512,512);
		this.gl.clearColor(0,0,0,0);
		this.gl.clear(this.gl.COLOR_BUFFER_BIT | this.gl.DEPTH_BUFFER_BIT);
		this.gl.enable(this.gl.DEPTH_TEST);
		this.renderMaterial(this.solidMaterial,this.defaultLight);
		this.gl.bindFramebuffer(this.gl.FRAMEBUFFER,null);
		var cc = this.defaultCamera.getComponent(libs_webgl_component_CameraComponent);
		this.gl.viewport(px,py,cc.canvasWidth,cc.canvasHeight);
		this.gl.clearColor(0,0,0,0);
		this.gl.clear(this.gl.COLOR_BUFFER_BIT | this.gl.DEPTH_BUFFER_BIT);
		this.gl.depthFunc(this.gl.LESS);
		if(this.skyboxMaterial != null) {
			this.gl.disable(this.gl.DEPTH_TEST);
			this.gl.cullFace(this.gl.BACK);
			this.renderMaterial(this.skyboxMaterial);
		}
		this.gl.enable(this.gl.DEPTH_TEST);
		this.gl.enable(this.gl.CULL_FACE);
		this.gl.cullFace(this.gl.FRONT);
		this.renderMaterial(this.outlineMaterial);
		this.gl.cullFace(this.gl.BACK);
		var _g_current = 0;
		var _g_array = this.materials;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var material = _g1_value;
			this.renderMaterial(material);
		}
		this.renderMaterial(this.depthMaterial);
	}
	,getNodes: function() {
		var actors = [];
		var _g_current = 0;
		var _g_array = this.materials;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			actors = actors.concat(value.nodes);
		}
		return actors;
	}
	,getNodeByName: function(name) {
		var nodes = this.getNodes();
		var node = null;
		var _g_current = 0;
		var _g_array = nodes;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			if(value.name == name) {
				node = value;
			}
		}
		return node;
	}
	,__class__: libs_webgl_Engine
};
var libs_webgl_TextureTool = function() { };
libs_webgl_TextureTool.__name__ = true;
libs_webgl_TextureTool.createDepthTexture = function(gl,width,height) {
	if(height == null) {
		height = 128;
	}
	if(width == null) {
		width = 128;
	}
	var texture = gl.createTexture();
	gl.bindTexture(gl.TEXTURE_2D,texture);
	gl.texImage2D(gl.TEXTURE_2D,0,gl.DEPTH_COMPONENT32F,width,height,0,gl.DEPTH_COMPONENT,gl.FLOAT,null);
	gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MAG_FILTER,gl.NEAREST);
	gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MIN_FILTER,gl.NEAREST);
	gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_S,gl.CLAMP_TO_EDGE);
	gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_T,gl.CLAMP_TO_EDGE);
	gl.bindTexture(gl.TEXTURE_2D,null);
	return texture;
};
libs_webgl_TextureTool.createTexture = function(gl,image) {
	var texture = gl.createTexture();
	gl.bindTexture(gl.TEXTURE_2D,texture);
	gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_S,gl.CLAMP_TO_EDGE);
	gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_T,gl.CLAMP_TO_EDGE);
	gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MIN_FILTER,gl.NEAREST);
	gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MAG_FILTER,gl.NEAREST);
	var mipLevel = 0;
	var internalFormat = gl.RGBA;
	var srcFormat = gl.RGBA;
	var srcType = gl.UNSIGNED_BYTE;
	gl.texImage2D(gl.TEXTURE_2D,mipLevel,internalFormat,srcFormat,srcType,image);
	gl.bindTexture(gl.TEXTURE_2D,null);
	return texture;
};
libs_webgl_TextureTool.createCubeMap = function(gl,width,height,showInBrowser) {
	if(showInBrowser == null) {
		showInBrowser = false;
	}
	if(height == null) {
		height = 128;
	}
	if(width == null) {
		width = 128;
	}
	var generateFace = function(ctx,faceColor,textColor,text) {
		var width = ctx.canvas.width;
		var height = ctx.canvas.height;
		ctx.fillStyle = faceColor;
		ctx.fillRect(0,0,width,height);
		ctx.font = "{" + width * 0.7 + "}px sans-serif";
		ctx.textAlign = "center";
		ctx.textBaseline = "middle";
		ctx.fillStyle = textColor;
		ctx.fillText(text,width / 2,height / 2);
	};
	var ctx = document.createElement("canvas").getContext("2d");
	var texture = gl.createTexture();
	gl.bindTexture(gl.TEXTURE_CUBE_MAP,texture);
	ctx.canvas.width = width;
	ctx.canvas.height = height;
	var faceInfos = [{ target : gl.TEXTURE_CUBE_MAP_POSITIVE_X, faceColor : "#F00", textColor : "#0FF", text : "+X"},{ target : gl.TEXTURE_CUBE_MAP_NEGATIVE_X, faceColor : "#FF0", textColor : "#00F", text : "-X"},{ target : gl.TEXTURE_CUBE_MAP_POSITIVE_Y, faceColor : "#0F0", textColor : "#F0F", text : "+Y"},{ target : gl.TEXTURE_CUBE_MAP_NEGATIVE_Y, faceColor : "#0FF", textColor : "#F00", text : "-Y"},{ target : gl.TEXTURE_CUBE_MAP_POSITIVE_Z, faceColor : "#00F", textColor : "#FF0", text : "+Z"},{ target : gl.TEXTURE_CUBE_MAP_NEGATIVE_Z, faceColor : "#F0F", textColor : "#0F0", text : "-Z"}];
	var _g_current = 0;
	var _g_array = faceInfos;
	while(_g_current < _g_array.length) {
		var _g1_value = _g_array[_g_current];
		var _g1_key = _g_current++;
		var index = _g1_key;
		var faceInfo = _g1_value;
		var target = faceInfo.target;
		var faceColor = faceInfo.faceColor;
		var textColor = faceInfo.textColor;
		var text = faceInfo.text;
		generateFace(ctx,faceColor,textColor,text);
		gl.texImage2D(target,0,gl.RGBA,gl.RGBA,gl.UNSIGNED_BYTE,ctx.canvas);
		if(showInBrowser) {
			ctx.canvas.toBlob(function(blob) {
				var img = new Image();
				img.src = URL.createObjectURL(blob);
				window.document.body.appendChild(img);
			});
		}
	}
	gl.generateMipmap(gl.TEXTURE_CUBE_MAP);
	gl.texParameteri(gl.TEXTURE_CUBE_MAP,gl.TEXTURE_MIN_FILTER,gl.LINEAR_MIPMAP_LINEAR);
	gl.bindTexture(gl.TEXTURE_CUBE_MAP,null);
	return texture;
};
libs_webgl_TextureTool.createCubeMapByURL = function(gl,width,height,posXUrl,negXUrl,posYUrl,negYUrl,posZUrl,negZUrl) {
	if(height == null) {
		height = 128;
	}
	if(width == null) {
		width = 128;
	}
	var texture = gl.createTexture();
	gl.bindTexture(gl.TEXTURE_CUBE_MAP,texture);
	var faceInfos = [{ target : gl.TEXTURE_CUBE_MAP_POSITIVE_X, url : posXUrl},{ target : gl.TEXTURE_CUBE_MAP_NEGATIVE_X, url : negXUrl},{ target : gl.TEXTURE_CUBE_MAP_POSITIVE_Y, url : posYUrl},{ target : gl.TEXTURE_CUBE_MAP_NEGATIVE_Y, url : negYUrl},{ target : gl.TEXTURE_CUBE_MAP_POSITIVE_Z, url : posZUrl},{ target : gl.TEXTURE_CUBE_MAP_NEGATIVE_Z, url : negZUrl}];
	var _g_current = 0;
	var _g_array = faceInfos;
	while(_g_current < _g_array.length) {
		var _g1_value = _g_array[_g_current];
		var _g1_key = _g_current++;
		var index = _g1_key;
		var faceInfo = _g1_value;
		var target = [faceInfo.target];
		var url = faceInfo.url;
		var level = [0];
		var internalFormat = [gl.RGBA];
		var format = [gl.RGBA];
		var type = [gl.UNSIGNED_BYTE];
		gl.texImage2D(target[0],level[0],internalFormat[0],width,height,0,format[0],type[0],null);
		var image = [new Image()];
		image[0].src = url;
		image[0].addEventListener("load",(function(image,type,format,internalFormat,level,target) {
			return function() {
				gl.bindTexture(gl.TEXTURE_CUBE_MAP,texture);
				gl.texImage2D(target[0],level[0],internalFormat[0],format[0],type[0],image[0]);
				gl.generateMipmap(gl.TEXTURE_CUBE_MAP);
			};
		})(image,type,format,internalFormat,level,target));
	}
	gl.generateMipmap(gl.TEXTURE_CUBE_MAP);
	gl.texParameteri(gl.TEXTURE_CUBE_MAP,gl.TEXTURE_MIN_FILTER,gl.LINEAR_MIPMAP_LINEAR);
	gl.bindTexture(gl.TEXTURE_CUBE_MAP,null);
	return texture;
};
var libs_webgl_actor_Actor = function(name) {
	this.transform = new libs_webgl_component_TransformComponent();
	this.components = [];
	libs_webgl_AObject.call(this,name);
};
libs_webgl_actor_Actor.__name__ = true;
libs_webgl_actor_Actor.__super__ = libs_webgl_AObject;
libs_webgl_actor_Actor.prototype = $extend(libs_webgl_AObject.prototype,{
	addComponent: function(component) {
		if(this.components.indexOf(component) == -1) {
			this.components.push(component);
			component.owner = this;
		}
	}
	,getComponent: function(clz) {
		var ret = null;
		var _g_current = 0;
		var _g_array = this.components;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			if(js_Boot.__instanceof(value,clz)) {
				ret = value;
				break;
			}
		}
		return ret;
	}
	,getComponents: function() {
		return this.components;
	}
	,update: function(time) {
		var _g_current = 0;
		var _g_array = this.components;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			value.update(time);
		}
	}
	,__class__: libs_webgl_actor_Actor
});
var libs_webgl_actor_CameraActor = function(name) {
	libs_webgl_actor_Actor.call(this,name);
	this.addComponent(new libs_webgl_component_CameraComponent());
	this.addComponent(new libs_webgl_component_ParticleComponent());
};
libs_webgl_actor_CameraActor.__name__ = true;
libs_webgl_actor_CameraActor.__super__ = libs_webgl_actor_Actor;
libs_webgl_actor_CameraActor.prototype = $extend(libs_webgl_actor_Actor.prototype,{
	__class__: libs_webgl_actor_CameraActor
});
var libs_webgl_actor_LightActor = function(name) {
	libs_webgl_actor_Actor.call(this,name);
	this.addComponent(new libs_webgl_component_MeshRenderComponent(new libs_webgl_mesh_CubeMesh()));
	this.addComponent(new libs_webgl_component_CameraComponent());
	this.addComponent(new libs_webgl_component_LightComponent());
	this.getComponent(libs_webgl_component_CameraComponent).fieldOfView = 100.0;
};
libs_webgl_actor_LightActor.__name__ = true;
libs_webgl_actor_LightActor.__super__ = libs_webgl_actor_Actor;
libs_webgl_actor_LightActor.prototype = $extend(libs_webgl_actor_Actor.prototype,{
	__class__: libs_webgl_actor_LightActor
});
var libs_webgl_actor_MeshActor = function(name) {
	libs_webgl_actor_Actor.call(this,name);
	var mesh = new libs_webgl_mesh_CubeMesh();
	this.addComponent(new libs_webgl_component_MeshRenderComponent(mesh));
};
libs_webgl_actor_MeshActor.__name__ = true;
libs_webgl_actor_MeshActor.__super__ = libs_webgl_actor_Actor;
libs_webgl_actor_MeshActor.prototype = $extend(libs_webgl_actor_Actor.prototype,{
	__class__: libs_webgl_actor_MeshActor
});
var libs_webgl_component_Component = function() {
};
libs_webgl_component_Component.__name__ = true;
libs_webgl_component_Component.prototype = {
	update: function(time) {
	}
	,__class__: libs_webgl_component_Component
};
var libs_webgl_component_CameraComponent = function() {
	this.canvasHeight = 512;
	this.canvasWidth = 512;
	this.far = 100;
	this.near = 1;
	this.fieldOfView = 40;
	libs_webgl_component_Component.call(this);
};
libs_webgl_component_CameraComponent.__name__ = true;
libs_webgl_component_CameraComponent.__super__ = libs_webgl_component_Component;
libs_webgl_component_CameraComponent.prototype = $extend(libs_webgl_component_Component.prototype,{
	getProjectMatrix: function() {
		var aspect = this.canvasWidth / this.canvasHeight;
		var radian = this.fieldOfView / 180 * Math.PI;
		var f = Math.tan(Math.PI * 0.5 - 0.5 * radian);
		var rangeInv = 1.0 / (this.near - this.far);
		var mat = mme_math_glmatrix_Mat4.fromArray([f / aspect,0,0,0,0,f,0,0,0,0,(this.near + this.far) * rangeInv,-1,0,0,this.near * this.far * rangeInv * 2,0]);
		return mat;
	}
	,__class__: libs_webgl_component_CameraComponent
});
var libs_webgl_component_CircleMoveComponent = function() {
	this.range = 10.0;
	this.speed = 1.0;
	libs_webgl_component_Component.call(this);
};
libs_webgl_component_CircleMoveComponent.__name__ = true;
libs_webgl_component_CircleMoveComponent.__super__ = libs_webgl_component_Component;
libs_webgl_component_CircleMoveComponent.prototype = $extend(libs_webgl_component_Component.prototype,{
	update: function(time) {
		libs_webgl_component_Component.prototype.update.call(this,time);
		this.owner.transform.position[0] = Math.cos(time / 1000 * this.speed) * this.range;
		this.owner.transform.position[2] = Math.sin(time / 1000 * this.speed) * this.range;
	}
	,__class__: libs_webgl_component_CircleMoveComponent
});
var libs_webgl_component_LightComponent = function() {
	this.limitInner = .65;
	this.limitOuter = .7;
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.color = this1;
	libs_webgl_component_Component.call(this);
	var y = this.color[2] = 1.0;
	var x = this.color[1] = y;
	this.color[0] = x;
};
libs_webgl_component_LightComponent.__name__ = true;
libs_webgl_component_LightComponent.__super__ = libs_webgl_component_Component;
libs_webgl_component_LightComponent.prototype = $extend(libs_webgl_component_Component.prototype,{
	__class__: libs_webgl_component_LightComponent
});
var libs_webgl_component_LookAtComponent = function() {
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.upDir = this1;
	libs_webgl_component_Component.call(this);
	this.upDir[1] = 1.0;
};
libs_webgl_component_LookAtComponent.__name__ = true;
libs_webgl_component_LookAtComponent.__super__ = libs_webgl_component_Component;
libs_webgl_component_LookAtComponent.prototype = $extend(libs_webgl_component_Component.prototype,{
	update: function(time) {
		libs_webgl_component_Component.prototype.update.call(this,time);
		if(this.target != null) {
			this.lookAt(this.target.transform.position,this.upDir);
		}
	}
	,lookAt: function(target,up) {
		var position = this.owner.transform.position;
		var zDir = mme_math_glmatrix_Vec3Tools.subtract(target,position);
		zDir = mme_math_glmatrix_Vec3Tools.normalize(zDir);
		zDir = mme_math_glmatrix_Vec3Tools.negate(zDir);
		var temp = up != null ? up : mme_math_glmatrix_Vec3.fromArray([0,1,0]);
		var xDir = mme_math_glmatrix_Vec3Tools.cross(temp,zDir);
		xDir = mme_math_glmatrix_Vec3Tools.normalize(xDir);
		var yDir = mme_math_glmatrix_Vec3Tools.cross(zDir,xDir);
		yDir = mme_math_glmatrix_Vec3Tools.normalize(yDir);
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out = this2;
		var mat = out;
		var v = xDir[0];
		mat[0] = v;
		var v = xDir[1];
		mat[1] = v;
		var v = xDir[2];
		mat[2] = v;
		var v = yDir[0];
		mat[4] = v;
		var v = yDir[1];
		mat[5] = v;
		var v = yDir[2];
		mat[6] = v;
		var v = zDir[0];
		mat[8] = v;
		var v = zDir[1];
		mat[9] = v;
		var v = zDir[2];
		mat[10] = v;
		var euler = this.rotationMatrixToEuler(mme_math_glmatrix_Mat4.toArray(mat));
		this.owner.transform.rotation[0] = euler[0];
		this.owner.transform.rotation[1] = euler[1];
		this.owner.transform.rotation[2] = euler[2];
	}
	,rotationMatrixToEuler: function(m) {
		var te = m;
		var m11 = te[0];
		var m12 = te[4];
		var m13 = te[8];
		var m21 = te[1];
		var m22 = te[5];
		var m23 = te[9];
		var m31 = te[2];
		var m32 = te[6];
		var m33 = te[10];
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var angles = this2;
		angles[1] = Math.asin(this.clamp(m13,-1,1));
		if(Math.abs(m13) < 0.9999999) {
			angles[0] = Math.atan2(-m23,m33);
			angles[2] = Math.atan2(-m12,m11);
		} else {
			angles[0] = Math.atan2(m32,m22);
			angles[2] = 0;
		}
		angles[0] = angles[0] / Math.PI * 180;
		angles[1] = angles[1] / Math.PI * 180;
		angles[2] = angles[2] / Math.PI * 180;
		return angles;
	}
	,clamp: function(m13,arg1,arg2) {
		return m13;
	}
	,__class__: libs_webgl_component_LookAtComponent
});
var libs_webgl_component_MeshRenderComponent = function(mesh) {
	libs_webgl_component_Component.call(this);
	this.mesh = mesh;
};
libs_webgl_component_MeshRenderComponent.__name__ = true;
libs_webgl_component_MeshRenderComponent.__super__ = libs_webgl_component_Component;
libs_webgl_component_MeshRenderComponent.prototype = $extend(libs_webgl_component_Component.prototype,{
	__class__: libs_webgl_component_MeshRenderComponent
});
var libs_webgl_component_ParticleComponent = function() {
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.rotVel = this1;
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.rotAcc = this1;
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.vel = this1;
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.acc = this1;
	libs_webgl_component_Component.call(this);
};
libs_webgl_component_ParticleComponent.__name__ = true;
libs_webgl_component_ParticleComponent.__super__ = libs_webgl_component_Component;
libs_webgl_component_ParticleComponent.prototype = $extend(libs_webgl_component_Component.prototype,{
	applyForce: function(force) {
		mme_math_glmatrix_Vec3Tools.add(this.acc,force,this.acc);
	}
	,applyTorque: function(force) {
		mme_math_glmatrix_Vec3Tools.add(this.rotAcc,force,this.rotAcc);
	}
	,update: function(time) {
		libs_webgl_component_Component.prototype.update.call(this,time);
		var pos = this.owner.transform.position;
		mme_math_glmatrix_Vec3Tools.add(this.vel,this.acc,this.vel);
		mme_math_glmatrix_Vec3Tools.scale(this.vel,.8,this.vel);
		mme_math_glmatrix_Vec3Tools.add(pos,this.vel,pos);
		mme_math_glmatrix_Vec3Tools.zero(this.acc);
		var rot = this.owner.transform.rotation;
		mme_math_glmatrix_Vec3Tools.add(this.rotVel,this.rotAcc,this.rotVel);
		mme_math_glmatrix_Vec3Tools.scale(this.rotVel,.8,this.rotVel);
		mme_math_glmatrix_Vec3Tools.add(rot,this.rotVel,rot);
		mme_math_glmatrix_Vec3Tools.zero(this.rotAcc);
	}
	,__class__: libs_webgl_component_ParticleComponent
});
var libs_webgl_component_TransformComponent = function() {
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.direction = this1;
	var this2 = new Array(16);
	var this1 = this2;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this1[3] = 0.0;
	this1[4] = 0.0;
	this1[6] = 0.0;
	this1[7] = 0.0;
	this1[8] = 0.0;
	this1[9] = 0.0;
	this1[11] = 0.0;
	this1[12] = 0.0;
	this1[13] = 0.0;
	this1[14] = 0.0;
	this1[0] = 1.0;
	this1[5] = 1.0;
	this1[10] = 1.0;
	this1[15] = 1.0;
	this.parentMatrix = this1;
	var this2 = new Array(16);
	var this1 = this2;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this1[3] = 0.0;
	this1[4] = 0.0;
	this1[6] = 0.0;
	this1[7] = 0.0;
	this1[8] = 0.0;
	this1[9] = 0.0;
	this1[11] = 0.0;
	this1[12] = 0.0;
	this1[13] = 0.0;
	this1[14] = 0.0;
	this1[0] = 1.0;
	this1[5] = 1.0;
	this1[10] = 1.0;
	this1[15] = 1.0;
	this.localMatrix = this1;
	var this2 = new Array(16);
	var this1 = this2;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this1[3] = 0.0;
	this1[4] = 0.0;
	this1[6] = 0.0;
	this1[7] = 0.0;
	this1[8] = 0.0;
	this1[9] = 0.0;
	this1[11] = 0.0;
	this1[12] = 0.0;
	this1[13] = 0.0;
	this1[14] = 0.0;
	this1[0] = 1.0;
	this1[5] = 1.0;
	this1[10] = 1.0;
	this1[15] = 1.0;
	this.globalMatrix = this1;
	var this2 = new Array(16);
	var this1 = this2;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this1[3] = 0.0;
	this1[4] = 0.0;
	this1[6] = 0.0;
	this1[7] = 0.0;
	this1[8] = 0.0;
	this1[9] = 0.0;
	this1[11] = 0.0;
	this1[12] = 0.0;
	this1[13] = 0.0;
	this1[14] = 0.0;
	this1[0] = 1.0;
	this1[5] = 1.0;
	this1[10] = 1.0;
	this1[15] = 1.0;
	this.scaleMatrix = this1;
	var this2 = new Array(16);
	var this1 = this2;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this1[3] = 0.0;
	this1[4] = 0.0;
	this1[6] = 0.0;
	this1[7] = 0.0;
	this1[8] = 0.0;
	this1[9] = 0.0;
	this1[11] = 0.0;
	this1[12] = 0.0;
	this1[13] = 0.0;
	this1[14] = 0.0;
	this1[0] = 1.0;
	this1[5] = 1.0;
	this1[10] = 1.0;
	this1[15] = 1.0;
	this.rotateMatrix = this1;
	var this2 = new Array(16);
	var this1 = this2;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this1[3] = 0.0;
	this1[4] = 0.0;
	this1[6] = 0.0;
	this1[7] = 0.0;
	this1[8] = 0.0;
	this1[9] = 0.0;
	this1[11] = 0.0;
	this1[12] = 0.0;
	this1[13] = 0.0;
	this1[14] = 0.0;
	this1[0] = 1.0;
	this1[5] = 1.0;
	this1[10] = 1.0;
	this1[15] = 1.0;
	this.positionMatrix = this1;
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.scale = this1;
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.rotation = this1;
	var this2 = new Array(3);
	var this1 = this2;
	this1[0] = 0.0;
	this1[1] = 0.0;
	this1[2] = 0.0;
	this.position = this1;
	libs_webgl_component_Component.call(this);
	var y = this.scale[2] = 1.0;
	var x = this.scale[1] = y;
	this.scale[0] = x;
};
libs_webgl_component_TransformComponent.__name__ = true;
libs_webgl_component_TransformComponent.__super__ = libs_webgl_component_Component;
libs_webgl_component_TransformComponent.prototype = $extend(libs_webgl_component_Component.prototype,{
	set_parent: function(p) {
		if(p == null) {
			if(this.parent != null) {
				this.parent = null;
			}
		} else {
			var localMat = mme_math_glmatrix_Mat4Tools.multiply(mme_math_glmatrix_Mat4Tools.invert(p.getMatrix()),this.getMatrix());
			var localPos = mme_math_glmatrix_Mat4Tools.getTranslation(localMat);
			this.position[0] = localPos[0];
			this.position[1] = localPos[1];
			this.position[2] = localPos[2];
			var euler = this.toEulerAngles(mme_math_glmatrix_Mat4Tools.getRotation(localMat));
			this.rotation[0] = euler[0];
			this.rotation[1] = euler[1];
			this.rotation[2] = euler[2];
			this.parent = p;
		}
		return p;
	}
	,toEulerAngles: function(q1) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var angles = this2;
		var test = q1[0] * q1[1] + q1[2] * q1[3];
		if(test > 0.499) {
			angles[1] = 2 * Math.atan2(q1[0],q1[3]);
			angles[2] = Math.PI / 2;
			angles[0] = 0;
			return angles;
		}
		if(test < -0.499) {
			angles[1] = -2 * Math.atan2(q1[0],q1[3]);
			angles[2] = -Math.PI / 2;
			angles[0] = 0;
			return angles;
		}
		var sqx = q1[0] * q1[0];
		var sqy = q1[1] * q1[1];
		var sqz = q1[2] * q1[2];
		angles[1] = Math.atan2(2 * q1[1] * q1[3] - 2 * q1[0] * q1[2],1 - 2 * sqy - 2 * sqz);
		angles[2] = Math.asin(2 * test);
		angles[0] = Math.atan2(2 * q1[0] * q1[3] - 2 * q1[1] * q1[2],1 - 2 * sqx - 2 * sqz);
		angles[0] = angles[0] / Math.PI * 180;
		angles[1] = angles[1] / Math.PI * 180;
		angles[2] = angles[2] / Math.PI * 180;
		return angles;
	}
	,getLocalMatrix: function() {
		mme_math_glmatrix_Mat4Tools.identity(this.positionMatrix);
		mme_math_glmatrix_Mat4Tools.identity(this.rotateMatrix);
		mme_math_glmatrix_Mat4Tools.identity(this.scaleMatrix);
		mme_math_glmatrix_Mat4Tools.identity(this.localMatrix);
		mme_math_glmatrix_Mat4Tools.translate(this.positionMatrix,this.position,this.positionMatrix);
		mme_math_glmatrix_Mat4Tools.rotateX(this.rotateMatrix,this.rotation[0] / 180 * Math.PI,this.rotateMatrix);
		mme_math_glmatrix_Mat4Tools.rotateY(this.rotateMatrix,this.rotation[1] / 180 * Math.PI,this.rotateMatrix);
		mme_math_glmatrix_Mat4Tools.rotateZ(this.rotateMatrix,this.rotation[2] / 180 * Math.PI,this.rotateMatrix);
		mme_math_glmatrix_Mat4Tools.scale(this.scaleMatrix,this.scale,this.scaleMatrix);
		mme_math_glmatrix_Mat4Tools.multiply(this.localMatrix,this.positionMatrix,this.localMatrix);
		mme_math_glmatrix_Mat4Tools.multiply(this.localMatrix,this.rotateMatrix,this.localMatrix);
		mme_math_glmatrix_Mat4Tools.multiply(this.localMatrix,this.scaleMatrix,this.localMatrix);
		return mme_math_glmatrix_Mat4Tools.clone(this.localMatrix);
	}
	,getMatrix: function() {
		mme_math_glmatrix_Mat4Tools.identity(this.globalMatrix);
		if(this.parent != null) {
			this.parentMatrix = mme_math_glmatrix_Mat4Tools.clone(this.parent.getMatrix());
		}
		mme_math_glmatrix_Mat4Tools.multiply(this.globalMatrix,this.parentMatrix,this.globalMatrix);
		mme_math_glmatrix_Mat4Tools.multiply(this.globalMatrix,this.getLocalMatrix(),this.globalMatrix);
		return mme_math_glmatrix_Mat4Tools.clone(this.globalMatrix);
	}
	,getForward: function() {
		this.direction[0] = this.globalMatrix[0];
		this.direction[1] = this.globalMatrix[1];
		this.direction[2] = this.globalMatrix[2];
		return this.direction;
	}
	,getRight: function() {
		this.direction[0] = this.globalMatrix[8];
		this.direction[1] = this.globalMatrix[9];
		this.direction[2] = this.globalMatrix[10];
		return this.direction;
	}
	,getUp: function() {
		this.direction[0] = this.globalMatrix[4];
		this.direction[1] = this.globalMatrix[5];
		this.direction[2] = this.globalMatrix[6];
		return this.direction;
	}
	,getBackward: function() {
		this.getForward();
		return mme_math_glmatrix_Vec3Tools.scale(this.direction,-1);
	}
	,getLeft: function() {
		this.getRight();
		return mme_math_glmatrix_Vec3Tools.scale(this.direction,-1);
	}
	,getDown: function() {
		this.getUp();
		return mme_math_glmatrix_Vec3Tools.scale(this.direction,-1);
	}
	,__class__: libs_webgl_component_TransformComponent
});
var libs_webgl_material_Material = function(shader,name) {
	this.autoAssignToMeshRender = true;
	this.nodes = [];
	this.uniforms = [];
	this.textures = [];
	libs_webgl_AObject.call(this,name);
	this.shader = shader;
};
libs_webgl_material_Material.__name__ = true;
libs_webgl_material_Material.__super__ = libs_webgl_AObject;
libs_webgl_material_Material.prototype = $extend(libs_webgl_AObject.prototype,{
	clearTextures: function() {
		this.textures = [];
	}
	,pushTexture: function(name,t,type) {
		this.textures.push([name,t,type]);
	}
	,pushUniform: function(location,value) {
		this.uniforms.push([location,value]);
	}
	,clearNodes: function() {
		while(this.nodes.length > 0) HxOverrides.remove(this.nodes,this.nodes[0]);
	}
	,pushNode: function(node) {
		if(node.getComponent(libs_webgl_component_MeshRenderComponent) != null) {
			if(this.nodes.indexOf(node) == -1) {
				this.nodes.push(node);
				if(this.autoAssignToMeshRender) {
					node.getComponent(libs_webgl_component_MeshRenderComponent).material = this;
				}
			}
		}
	}
	,removeNode: function(node) {
		if(this.nodes.indexOf(node) > -1) {
			HxOverrides.remove(this.nodes,node);
		}
	}
	,glSetTextureAndUniform: function() {
		var gl = libs_webgl_Engine.inst().gl;
		var _g_current = 0;
		var _g_array = this.textures;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			var locationKey = value[0];
			var texture = value[1];
			var type = value[2];
			var location = Reflect.field(this.shader.uniformKey,locationKey);
			gl.uniform1i(location,index);
			gl.activeTexture(gl.TEXTURE0 + index);
			gl.bindTexture(type,texture);
		}
		var _g_current = 0;
		var _g_array = this.uniforms;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var item = _g1_value;
			var location = Reflect.field(this.shader.uniformKey,item[0]);
			var value = item[1];
			if(js_Boot.getClass(value) == Array) {
				gl.uniform3fv(location,value);
			} else {
				gl.uniform1f(location,value);
			}
		}
	}
	,__class__: libs_webgl_material_Material
});
var libs_webgl_material_shader_Shader = function(name) {
	this.uniformKey = { };
	libs_webgl_AObject.call(this,name);
	this.gl = libs_webgl_Engine.inst().gl;
	this.program = this.gl.createProgram();
	var vertexShader = libs_webgl_material_shader_Shader.createShader(this.gl,this.gl.VERTEX_SHADER,this.getVS());
	var fragmentShader = libs_webgl_material_shader_Shader.createShader(this.gl,this.gl.FRAGMENT_SHADER,this.getFS());
	this.gl.attachShader(this.program,vertexShader);
	this.gl.attachShader(this.program,fragmentShader);
	this.gl.linkProgram(this.program);
	this.gl.useProgram(this.program);
	var uniformList = this.getUniformList();
	var _g_current = 0;
	var _g_array = uniformList;
	while(_g_current < _g_array.length) {
		var _g1_value = _g_array[_g_current];
		var _g1_key = _g_current++;
		var index = _g1_key;
		var value = _g1_value;
		var uniformName = uniformList[index];
		var uniform = this.gl.getUniformLocation(this.program,uniformName);
		this.uniformKey[uniformName] = uniform;
	}
};
libs_webgl_material_shader_Shader.__name__ = true;
libs_webgl_material_shader_Shader.createShader = function(gl,type,source) {
	var shader = gl.createShader(type);
	gl.shaderSource(shader,source);
	gl.compileShader(shader);
	var success = gl.getShaderParameter(shader,gl.COMPILE_STATUS);
	if(success) {
		return shader;
	}
	console.log("src/libs/webgl/material/shader/Shader.hx:38:",gl.getShaderInfoLog(shader));
	gl.deleteShader(shader);
	return null;
};
libs_webgl_material_shader_Shader.__super__ = libs_webgl_AObject;
libs_webgl_material_shader_Shader.prototype = $extend(libs_webgl_AObject.prototype,{
	getVS: function() {
		throw haxe_Exception.thrown("plz override this function!");
	}
	,getFS: function() {
		throw haxe_Exception.thrown("plz override this function!");
	}
	,getUniformList: function() {
		throw haxe_Exception.thrown("plz override this function!");
	}
	,__class__: libs_webgl_material_shader_Shader
});
var libs_webgl_material_shader_BasicShader = function(name) {
	libs_webgl_material_shader_Shader.call(this,name);
};
libs_webgl_material_shader_BasicShader.__name__ = true;
libs_webgl_material_shader_BasicShader.__super__ = libs_webgl_material_shader_Shader;
libs_webgl_material_shader_BasicShader.prototype = $extend(libs_webgl_material_shader_Shader.prototype,{
	getVS: function() {
		var s = "#version 300 es\r\n        \r\n                in vec3 a_vertex;\r\n                in vec2 a_texcoord;\r\n                in vec3 a_normal;\r\n                in vec3 a_tangent;\r\n                \r\n                uniform mat4 u_modelMat;\r\n                uniform mat4 u_viewMat;\r\n                uniform mat4 u_projectMat;\r\n                uniform vec3 u_lightWorldPos;\r\n                uniform vec3 u_viewWorldPos;\r\n\r\n                out vec3 v_worldNormal;\r\n                out vec3 v_worldPos;\r\n                out vec3 v_worldTangent;\r\n                out vec3 v_worldBinormal;\r\n                out vec2 v_uv;\r\n                out vec3 v_tangent;\r\n                out mat3 v_tangentMat;\r\n                out vec3 v_lightDir;\r\n                out vec3 v_viewDir;\r\n\r\n                uniform mat4 u_lightViewMat;\r\n                uniform mat4 u_lightProjectMat;\r\n                out vec4 v_projectedTexcoord;\r\n                \r\n                void main(){\r\n                    mat4 fixScaleMatrix = transpose(inverse(u_modelMat));\r\n                    v_worldNormal = normalize((fixScaleMatrix * vec4(a_normal, 0)).xyz);\r\n                    v_worldPos = (u_modelMat * vec4(a_vertex, 1)).xyz;\r\n                    v_worldTangent = normalize((fixScaleMatrix * vec4(a_tangent, 0)).xyz);\r\n                    v_worldBinormal = normalize(cross(v_worldNormal, v_worldTangent));\r\n                    \r\n                    v_uv = a_texcoord;\r\n\r\n                    // 把物件的點坐標轉換成燈光的局部坐標，拿來檢查是否產生陰影\r\n                    mat4 lightMvp = u_lightProjectMat * inverse(u_lightViewMat) * u_modelMat;\r\n                    v_projectedTexcoord = lightMvp * vec4(a_vertex, 1.);\r\n                    \r\n                    vec3 binormal = cross(normalize(a_normal), normalize(a_tangent));\r\n                    v_tangentMat = mat3(a_tangent, binormal, a_normal);\r\n                    \r\n                    vec4 localLightDir = inverse(u_modelMat) * vec4(normalize(u_lightWorldPos - v_worldPos), 0);\r\n                    v_lightDir = inverse(v_tangentMat) * localLightDir.xyz;\r\n                    \r\n                    vec4 localViewDir = inverse(u_modelMat) * vec4(normalize(u_viewWorldPos - v_worldPos), 0);\r\n                    v_viewDir = inverse(v_tangentMat) * localViewDir.xyz;\r\n                    \r\n                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;\r\n                    gl_Position = mvp * vec4(a_vertex, 1.);\r\n                }\r\n                ";
		return s;
	}
	,getFS: function() {
		var s = "#version 300 es\r\n                precision highp float;\r\n                \r\n                in vec3 v_worldNormal;\r\n                in vec3 v_worldPos;\r\n                in vec3 v_worldTangent;\r\n                in vec3 v_worldBinormal;\r\n                in vec2 v_uv;\r\n                in vec3 v_lightDir;\r\n                in vec3 v_viewDir;\r\n\r\n                in vec4 v_projectedTexcoord;\r\n                \r\n                uniform vec3 u_lightColor;\r\n                uniform vec3 u_lightWorldPos;\r\n                uniform vec3 u_lightWorldDirection;\r\n                uniform float u_lightInner;\r\n                uniform float u_lightOuter;\r\n                \r\n                uniform vec3 u_viewWorldPos;\r\n                uniform vec3 u_diffuseColor;\r\n                uniform vec3 u_specularColor;\r\n                uniform float u_gloss;\r\n                uniform float u_bump;\r\n                uniform sampler2D u_diffuseMap;\r\n                uniform sampler2D u_normalMap;\r\n                uniform sampler2D u_depthMap;\r\n                \r\n                out vec4 outColor;\r\n\r\n                float getShadowLight(vec3 projectUv){\r\n                    vec3 projectedDepth = texture(u_depthMap, projectUv.xy).rgb;\r\n                    bool inRange = \r\n                        projectUv.x >= .0 && \r\n                        projectUv.x <= 1.0 &&\r\n                        projectUv.y >= .0 &&\r\n                        projectUv.y <= 1.0;\r\n                    float shadowLight = (inRange && projectedDepth.r <= projectUv.z) ? 0.0 : 1.0;\r\n                    return shadowLight;\r\n                }\r\n\r\n                void main() {\r\n                    \r\n                    vec3 worldLightDir = normalize( u_lightWorldPos - v_worldPos);\r\n                    vec3 worldViewDir = normalize( u_viewWorldPos - v_worldPos);\r\n                    vec3 tangentNormal = texture( u_normalMap, v_uv ).rgb;\r\n                    tangentNormal.rg *= 2.0;\r\n                    tangentNormal.rg -= 1.0;\r\n                    tangentNormal.b = sqrt( 1.0 - clamp( dot( tangentNormal.xy, tangentNormal.xy ), 0., 1.));\r\n                    tangentNormal.xy *= u_bump;\r\n                    vec3 worldNormal = mat3(v_worldTangent, v_worldBinormal, v_worldNormal ) * tangentNormal;\r\n                    worldNormal = normalize(worldNormal);\r\n                    \r\n                    float dotFromDirection = dot(worldLightDir, -normalize(u_lightWorldDirection));\r\n                    float limitRange = u_lightOuter - u_lightInner;\r\n                    float inLight = smoothstep(u_lightInner, u_lightOuter, dotFromDirection);\r\n                    float light = inLight * max(0., dot(worldNormal, worldLightDir));\r\n                    vec3 albedo = texture( u_diffuseMap, v_uv ).rgb * u_diffuseColor;\r\n                    vec3 ambient = vec3(.0) * albedo;\r\n                    vec3 diffuse = u_lightColor * albedo * light;\r\n                    vec3 halfDir = normalize( worldLightDir + worldViewDir );\r\n                    vec3 specualr = u_lightColor * u_specularColor * pow(max(0., dot(worldNormal, halfDir)), u_gloss);\r\n                    vec3 col = ambient + diffuse + specualr;\r\n\r\n                    vec3 projectUv = v_projectedTexcoord.xyz; // 此時拿到的投影坐標還不是-1~1\r\n                    projectUv /= v_projectedTexcoord.w; // 把各分量除以w之後才會得到-1~1\r\n                    projectUv *= .5; // 轉換為-0.5~0.5\r\n                    projectUv += .5; // 轉換為0~1\r\n                    projectUv.z += -0.005; // 做一點偏離，解決阴影痤疮（shadow acne）\r\n                    \r\n                    // 假的pcss\r\n                    // float radius = smoothstep(.91, .93, projectUv.z) * 1.0 / 512.0;\r\n                    float radius = 1.0 / 512.0;\r\n\r\n                    // 軟陰影計算PCF\r\n                    float factor = 0.0;\r\n                    int calcuCount = 0;\r\n                    for (int y = -3; y <= 3; y++ ){\r\n                        for( int x = -3; x <= 3; x++){\r\n                            vec3 offsets = vec3(float(x) * radius, float(y) * radius, 0.0);\r\n                            vec3 uvc = projectUv + offsets;\r\n\r\n                            // 得到燈光投影的深度圖，用以上得出的uv坐標\r\n                            factor += getShadowLight(uvc);\r\n                            calcuCount += 1;\r\n                        }\r\n                    }\r\n                    factor /= float(calcuCount);\r\n                    outColor = vec4(vec3(factor * col), 1.0);\r\n\r\n\r\n                    // outColor = vec4(vec3(smoothstep(.91, .93, projectUv.z)), 1.0);\r\n                }\r\n                ";
		return s;
	}
	,getUniformList: function() {
		return ["u_modelMat","u_viewMat","u_projectMat","u_viewWorldPos","u_lightViewMat","u_lightProjectMat","u_lightWorldPos","u_lightWorldDirection","u_lightOuter","u_lightInner","u_lightColor","u_diffuseColor","u_specularColor","u_gloss","u_bump","u_diffuseMap","u_normalMap","u_depthMap"];
	}
	,__class__: libs_webgl_material_shader_BasicShader
});
var libs_webgl_material_shader_ColorShader = function(name) {
	libs_webgl_material_shader_Shader.call(this,name);
};
libs_webgl_material_shader_ColorShader.__name__ = true;
libs_webgl_material_shader_ColorShader.__super__ = libs_webgl_material_shader_Shader;
libs_webgl_material_shader_ColorShader.prototype = $extend(libs_webgl_material_shader_Shader.prototype,{
	getVS: function() {
		var s = "#version 300 es\r\n        \r\n                in vec3 a_vertex;\r\n                in vec2 a_texcoord;\r\n                in vec3 a_normal;\r\n                in vec3 a_tangent;\r\n                \r\n                uniform mat4 u_modelMat;\r\n                uniform mat4 u_viewMat;\r\n                uniform mat4 u_projectMat;\r\n                uniform vec3 u_lightWorldPos;\r\n                uniform vec3 u_viewWorldPos;\r\n                \r\n                out vec3 v_worldNormal;\r\n                out vec3 v_worldPos;\r\n                \r\n                void main(){\r\n                    mat4 fixScaleMatrix = transpose(inverse(u_modelMat));\r\n                    v_worldNormal = normalize((fixScaleMatrix * vec4(a_normal, 0)).xyz);\r\n                    v_worldPos = (fixScaleMatrix * vec4(a_vertex, 1)).xyz;\r\n                    \r\n                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;\r\n                    gl_Position = mvp * vec4(a_vertex, 1.);\r\n                }\r\n                ";
		return s;
	}
	,getFS: function() {
		var s = "#version 300 es\r\n                precision highp float;\r\n                \r\n                in vec3 v_worldNormal;\r\n                in vec3 v_worldPos;\r\n                \r\n                uniform vec3 u_lightWorldPos;\r\n                uniform vec3 u_viewWorldPos;\r\n                uniform vec3 u_lightColor;\r\n                uniform vec3 u_diffuseColor;\r\n                uniform vec3 u_specColor;\r\n                uniform float u_gloss;\r\n                \r\n                out vec4 outColor;\r\n                void main() {\r\n                    vec3 worldLightDir = normalize( u_lightWorldPos - v_worldPos);\r\n                    vec3 worldViewDir = normalize( u_viewWorldPos - v_worldPos);\r\n                    vec3 worldNormal = normalize(v_worldNormal);\r\n                    vec3 albedo = u_diffuseColor;\r\n                    vec3 ambient = vec3(.2) * albedo;\r\n                    vec3 diffuse = u_lightColor * albedo * max(0., dot(worldNormal, worldLightDir));\r\n                    vec3 halfDir = normalize( worldLightDir + worldViewDir );\r\n                    vec3 specualr = u_lightColor * u_specColor * pow(max(0., dot(worldNormal, halfDir)), u_gloss);\r\n                    outColor = vec4(ambient + diffuse + specualr,1);\r\n                    //outColor = vec4(u_specColor, 1.);\r\n                }\r\n                ";
		return s;
	}
	,getUniformList: function() {
		return ["u_modelMat","u_viewMat","u_projectMat","u_viewWorldPos","u_lightWorldPos","u_lightColor","u_diffuseColor","u_specColor","u_specColor","u_gloss"];
	}
	,__class__: libs_webgl_material_shader_ColorShader
});
var libs_webgl_material_shader_CubeMapShader = function(name) {
	libs_webgl_material_shader_Shader.call(this,name);
};
libs_webgl_material_shader_CubeMapShader.__name__ = true;
libs_webgl_material_shader_CubeMapShader.__super__ = libs_webgl_material_shader_Shader;
libs_webgl_material_shader_CubeMapShader.prototype = $extend(libs_webgl_material_shader_Shader.prototype,{
	getVS: function() {
		var s = "#version 300 es\r\n        \r\n                in vec3 a_vertex;\r\n                in vec2 a_texcoord;\r\n\r\n                uniform mat4 u_modelMat;\r\n                uniform mat4 u_viewMat;\r\n                uniform mat4 u_projectMat;\r\n\r\n                out vec3 v_normal;\r\n                \r\n                void main(){\r\n                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;\r\n                    gl_Position = mvp * vec4(a_vertex, 1.);\r\n\r\n                    v_normal = normalize(a_vertex);\r\n                }\r\n                ";
		return s;
	}
	,getFS: function() {
		var s = "#version 300 es\r\n                precision highp float;\r\n                \r\n                in vec3 v_normal;\r\n\r\n                uniform samplerCube u_texture;\r\n                \r\n                out vec4 outColor;\r\n                void main() {\r\n                    outColor = texture(u_texture, normalize(v_normal));\r\n                }\r\n                ";
		return s;
	}
	,getUniformList: function() {
		return ["u_modelMat","u_viewMat","u_projectMat","u_texture"];
	}
	,__class__: libs_webgl_material_shader_CubeMapShader
});
var libs_webgl_material_shader_EnviromentMapShader = function(name) {
	libs_webgl_material_shader_Shader.call(this,name);
};
libs_webgl_material_shader_EnviromentMapShader.__name__ = true;
libs_webgl_material_shader_EnviromentMapShader.__super__ = libs_webgl_material_shader_Shader;
libs_webgl_material_shader_EnviromentMapShader.prototype = $extend(libs_webgl_material_shader_Shader.prototype,{
	getVS: function() {
		var s = "#version 300 es\r\n        \r\n                in vec3 a_vertex;\r\n                in vec2 a_texcoord;\r\n                in vec3 a_normal;\r\n\r\n                uniform mat4 u_modelMat;\r\n                uniform mat4 u_viewMat;\r\n                uniform mat4 u_projectMat;\r\n\r\n                out vec3 v_worldVertex;\r\n                out vec3 v_worldNormal;\r\n                \r\n                void main(){\r\n                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;\r\n                    gl_Position = mvp * vec4(a_vertex, 1.);\r\n\r\n                    v_worldVertex = (u_modelMat * vec4(a_vertex, 1.)).xyz;\r\n                    v_worldNormal = mat3(u_modelMat) * a_normal;\r\n                }\r\n                ";
		return s;
	}
	,getFS: function() {
		var s = "#version 300 es\r\n                precision highp float;\r\n                \r\n                in vec3 v_worldVertex;\r\n                in vec3 v_worldNormal;\r\n\r\n                uniform samplerCube u_texture;\r\n                uniform vec3 u_viewWorldPos;\r\n                \r\n                out vec4 outColor;\r\n                void main() {\r\n                    vec3 worldNormal = normalize(v_worldNormal);\r\n                    vec3 eyeToSurfaceDir = normalize(v_worldVertex - u_viewWorldPos);\r\n                    vec3 direction = reflect(eyeToSurfaceDir,worldNormal);\r\n                    outColor = texture(u_texture, normalize(direction));\r\n                    // outColor = vec4(direction, 1.0);\r\n                }\r\n                ";
		return s;
	}
	,getUniformList: function() {
		return ["u_modelMat","u_viewMat","u_projectMat","u_texture","u_viewWorldPos"];
	}
	,__class__: libs_webgl_material_shader_EnviromentMapShader
});
var libs_webgl_material_shader_OnlyTextureShader = function(name) {
	libs_webgl_material_shader_Shader.call(this,name);
};
libs_webgl_material_shader_OnlyTextureShader.__name__ = true;
libs_webgl_material_shader_OnlyTextureShader.__super__ = libs_webgl_material_shader_Shader;
libs_webgl_material_shader_OnlyTextureShader.prototype = $extend(libs_webgl_material_shader_Shader.prototype,{
	getVS: function() {
		var s = "#version 300 es\r\n        \r\n                in vec3 a_vertex;\r\n                in vec2 a_texcoord;\r\n                \r\n                uniform mat4 u_modelMat;\r\n                uniform mat4 u_viewMat;\r\n                uniform mat4 u_projectMat;\r\n\r\n                out vec2 v_uv;\r\n                \r\n                void main(){\r\n                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;\r\n                    gl_Position = mvp * vec4(a_vertex, 1.);\r\n\r\n                    v_uv = a_texcoord;\r\n                }\r\n                ";
		return s;
	}
	,getFS: function() {
		var s = "#version 300 es\r\n                precision highp float;\r\n\r\n                in vec2 v_uv;\r\n\r\n                uniform sampler2D u_texture;\r\n                \r\n                out vec4 outColor;\r\n                void main() {\r\n                    outColor = vec4( texture(u_texture, v_uv).rrr, 1.);\r\n                }\r\n                ";
		return s;
	}
	,getUniformList: function() {
		return ["u_modelMat","u_viewMat","u_projectMat","u_texture"];
	}
	,__class__: libs_webgl_material_shader_OnlyTextureShader
});
var libs_webgl_material_shader_OutlineShader = function(name) {
	libs_webgl_material_shader_Shader.call(this,name);
};
libs_webgl_material_shader_OutlineShader.__name__ = true;
libs_webgl_material_shader_OutlineShader.__super__ = libs_webgl_material_shader_Shader;
libs_webgl_material_shader_OutlineShader.prototype = $extend(libs_webgl_material_shader_Shader.prototype,{
	getVS: function() {
		var s = "#version 300 es\r\n        \r\n                in vec3 a_vertex;\r\n                in vec2 a_texcoord;\r\n                in vec3 a_normal;\r\n                in vec3 a_tangent;\r\n                \r\n                uniform mat4 u_modelMat;\r\n                uniform mat4 u_viewMat;\r\n                uniform mat4 u_projectMat;\r\n\r\n                uniform float u_thickness;\r\n                \r\n                void main(){\r\n                    vec3 extend = a_vertex + normalize(a_vertex) * u_thickness;\r\n                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;\r\n                    gl_Position = mvp * vec4(extend, 1.);\r\n                }\r\n                ";
		return s;
	}
	,getFS: function() {
		var s = "#version 300 es\r\n                precision highp float;\r\n                uniform vec3 u_color;\r\n                \r\n                out vec4 outColor;\r\n                void main() {\r\n                    outColor = vec4( u_color, 1);\r\n                }\r\n                ";
		return s;
	}
	,getUniformList: function() {
		return ["u_modelMat","u_viewMat","u_projectMat","u_color","u_thickness"];
	}
	,__class__: libs_webgl_material_shader_OutlineShader
});
var libs_webgl_material_shader_SkyboxShader = function(name) {
	libs_webgl_material_shader_Shader.call(this,name);
};
libs_webgl_material_shader_SkyboxShader.__name__ = true;
libs_webgl_material_shader_SkyboxShader.__super__ = libs_webgl_material_shader_Shader;
libs_webgl_material_shader_SkyboxShader.prototype = $extend(libs_webgl_material_shader_Shader.prototype,{
	getVS: function() {
		var s = "#version 300 es\r\n        \r\n                in vec3 a_vertex;\r\n\r\n                uniform mat4 u_modelMat;\r\n                uniform mat4 u_viewMat;\r\n                uniform mat4 u_projectMat;\r\n\r\n                out vec3 v_vertex;\r\n                out mat4 v_mat;\r\n                \r\n                void main(){\r\n                    v_vertex = a_vertex;\r\n                    gl_Position = vec4(a_vertex.xy, -.9, 1.);\r\n\r\n                    // 環境貼圖不需要平移，所以這裏把攝像機的坐標設爲0\r\n                    mat4 ignoreTransformViewMat = u_viewMat;\r\n                    ignoreTransformViewMat[3][0] = 0.0;\r\n                    ignoreTransformViewMat[3][1] = 0.0;\r\n                    ignoreTransformViewMat[3][2] = 0.0;\r\n\r\n                    // 把投影空間坐標xyz為-1~1轉換囘3d坐標的矩陣\r\n                    v_mat = ignoreTransformViewMat * inverse(u_projectMat);\r\n                }\r\n                ";
		return s;
	}
	,getFS: function() {
		var s = "#version 300 es\r\n                precision highp float;\r\n                \r\n                in vec3 v_vertex;\r\n                in mat4 v_mat;\r\n\r\n                uniform samplerCube u_texture;\r\n                \r\n                out vec4 outColor;\r\n                void main() {\r\n\r\n                    vec4 t = v_mat * vec4(v_vertex, 1.0);\r\n                    outColor = texture(u_texture, normalize(t.xyz / t.w));\r\n                }\r\n                ";
		return s;
	}
	,getUniformList: function() {
		return ["u_modelMat","u_viewMat","u_projectMat","u_texture"];
	}
	,__class__: libs_webgl_material_shader_SkyboxShader
});
var libs_webgl_material_shader_SolidColorShader = function(name) {
	libs_webgl_material_shader_Shader.call(this,name);
};
libs_webgl_material_shader_SolidColorShader.__name__ = true;
libs_webgl_material_shader_SolidColorShader.__super__ = libs_webgl_material_shader_Shader;
libs_webgl_material_shader_SolidColorShader.prototype = $extend(libs_webgl_material_shader_Shader.prototype,{
	getVS: function() {
		var s = "#version 300 es\r\n        \r\n                in vec3 a_vertex;\r\n                in vec2 a_texcoord;\r\n                \r\n                uniform mat4 u_modelMat;\r\n                uniform mat4 u_viewMat;\r\n                uniform mat4 u_projectMat;\r\n                \r\n                void main(){\r\n                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;\r\n                    gl_Position = mvp * vec4(a_vertex, 1.);\r\n                }\r\n                ";
		return s;
	}
	,getFS: function() {
		var s = "#version 300 es\r\n                precision highp float;\r\n                uniform vec3 u_color;\r\n                \r\n                out vec4 outColor;\r\n                void main() {\r\n                    outColor = vec4( u_color, 1);\r\n                }\r\n                ";
		return s;
	}
	,getUniformList: function() {
		return ["u_modelMat","u_viewMat","u_projectMat","u_color"];
	}
	,__class__: libs_webgl_material_shader_SolidColorShader
});
var libs_webgl_mesh_Mesh = function() {
	this.bitangents = [];
	this.tangents = [];
	this.createVAO();
};
libs_webgl_mesh_Mesh.__name__ = true;
libs_webgl_mesh_Mesh.prototype = {
	createVAO: function() {
		this.calculateTangent();
		var gl = libs_webgl_Engine.inst().gl;
		this.vao = gl.createVertexArray();
		gl.bindVertexArray(this.vao);
		var bindingInfo = this.getBindingInfo();
		var _g_current = 0;
		var _g_array = bindingInfo;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var info = _g1_value;
			var attriName = info[0];
			var bufferData = info[6];
			var attriLocation = index;
			gl.enableVertexAttribArray(attriLocation);
			gl.bindBuffer(gl.ARRAY_BUFFER,gl.createBuffer());
			gl.bufferData(gl.ARRAY_BUFFER,bufferData,gl.STATIC_DRAW);
			var size = info[1];
			var type = info[2];
			var normalize = info[3];
			var stride = info[4];
			var offset = info[5];
			gl.vertexAttribPointer(attriLocation,size,type,normalize,stride,offset);
			gl.bindBuffer(gl.ARRAY_BUFFER,null);
		}
		gl.bindVertexArray(null);
	}
	,getBindingInfo: function() {
		var gl = libs_webgl_Engine.inst().gl;
		return [["a_vertex",3,gl.FLOAT,false,0,0,new Float32Array(this.getGLVertices())],["a_texcoord",2,gl.FLOAT,false,0,0,new Float32Array(this.getTexCoords())],["a_normal",3,gl.FLOAT,false,0,0,new Float32Array(this.getNormals())],["a_tangent",3,gl.FLOAT,false,0,0,new Float32Array(this.getTangents())],["a_bitangent",3,gl.FLOAT,false,0,0,new Float32Array(this.getBITangents())]];
	}
	,getVertices: function() {
		throw haxe_Exception.thrown("plz override getVertices!");
	}
	,getIndices: function() {
		throw haxe_Exception.thrown("plz override getIndices!");
	}
	,getTexCoords: function() {
		throw haxe_Exception.thrown("plz override getTexCoords!");
	}
	,getNormals: function() {
		throw haxe_Exception.thrown("plz override getNormals!");
	}
	,getTangents: function() {
		return this.tangents;
	}
	,getBITangents: function() {
		return this.bitangents;
	}
	,calculateTangent: function() {
		this.tangents = [];
		this.bitangents = [];
		var verts = this.getGLVertices();
		var uvs = this.getTexCoords();
		var triangleId = 0;
		var total = verts.length;
		var step = 9;
		var i = 0;
		while(i < total) {
			triangleId = Math.floor(i / 9);
			var v0_0 = verts[i];
			var v0_1 = verts[i + 1];
			var v0_2 = verts[i + 2];
			var v1_0 = verts[i + 3];
			var v1_1 = verts[i + 4];
			var v1_2 = verts[i + 5];
			var v2_0 = verts[i + 6];
			var v2_1 = verts[i + 7];
			var v2_2 = verts[i + 8];
			var uvId = triangleId * 6;
			var uv0_0 = uvs[uvId];
			var uv0_1 = uvs[uvId + 1];
			var uv1_0 = uvs[uvId + 2];
			var uv1_1 = uvs[uvId + 3];
			var uv2_0 = uvs[uvId + 4];
			var uv2_1 = uvs[uvId + 5];
			var deltaPos1_0 = v1_0 - v0_0;
			var deltaPos1_1 = v1_1 - v0_1;
			var deltaPos1_2 = v1_2 - v0_2;
			var deltaPos2_0 = v2_0 - v0_0;
			var deltaPos2_1 = v2_1 - v0_1;
			var deltaPos2_2 = v2_2 - v0_2;
			var deltaUv1_0 = uv1_0 - uv0_0;
			var deltaUv1_1 = uv1_1 - uv0_1;
			var deltaUv2_0 = uv2_0 - uv0_0;
			var deltaUv2_1 = uv2_1 - uv0_1;
			var r = 1.0 / (deltaUv1_0 * deltaUv2_1 - deltaUv1_1 * deltaUv2_0);
			var tangent = [(deltaPos1_0 * deltaUv2_1 - deltaPos2_0 * deltaUv1_1) * r,(deltaPos1_1 * deltaUv2_1 - deltaPos2_1 * deltaUv1_1) * r,(deltaPos1_2 * deltaUv2_1 - deltaPos2_2 * deltaUv1_1) * r];
			var bitangent = [(deltaPos2_0 * deltaUv1_0 - deltaPos1_0 * deltaUv2_0) * r,(deltaPos2_1 * deltaUv1_0 - deltaPos1_1 * deltaUv2_0) * r,(deltaPos2_2 * deltaUv1_0 - deltaPos1_2 * deltaUv2_0) * r];
			this.tangents = this.tangents.concat(tangent);
			this.tangents = this.tangents.concat(tangent);
			this.tangents = this.tangents.concat(tangent);
			this.bitangents = this.bitangents.concat(bitangent);
			this.bitangents = this.bitangents.concat(bitangent);
			this.bitangents = this.bitangents.concat(bitangent);
			i += step;
		}
	}
	,getCount: function() {
		return this.getIndices().length;
	}
	,getGLVertices: function() {
		return this.getDrawArrayData(this.getVertices(),3);
	}
	,getDrawArrayData: function(list,count) {
		var ary = [];
		var indices = this.getIndices();
		var _g_current = 0;
		var _g_array = indices;
		while(_g_current < _g_array.length) {
			var _g1_value = _g_array[_g_current];
			var _g1_key = _g_current++;
			var index = _g1_key;
			var value = _g1_value;
			var start = indices[index] * count;
			var _g = 0;
			var _g1 = count;
			while(_g < _g1) {
				var j = _g++;
				ary.push(list[start + j]);
			}
		}
		return ary;
	}
	,__class__: libs_webgl_mesh_Mesh
};
var libs_webgl_mesh_CubeMesh = function() {
	libs_webgl_mesh_Mesh.call(this);
};
libs_webgl_mesh_CubeMesh.__name__ = true;
libs_webgl_mesh_CubeMesh.__super__ = libs_webgl_mesh_Mesh;
libs_webgl_mesh_CubeMesh.prototype = $extend(libs_webgl_mesh_Mesh.prototype,{
	getVertices: function() {
		return [0.5,.5,0.5,0.5,0.5,-0.5,-0.5,0.5,-0.5,-0.5,0.5,0.5,0.5,-0.5,0.5,0.5,-0.5,-0.5,-0.5,-0.5,-0.5,-0.5,-0.5,0.5];
	}
	,getIndices: function() {
		return [0,1,3,1,2,3,7,3,6,3,2,6,4,0,7,0,3,7,5,1,4,1,0,4,6,2,5,2,1,5,4,7,5,7,6,5];
	}
	,getTexCoords: function() {
		return [1,0,1,1,0,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,1,0,0];
	}
	,getNormals: function() {
		return [0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,-1,0,0,-1,0,0,-1,0,0,-1,0,0,-1,0,0,-1,0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,-1,0,0,-1,0,0,-1,0,0,-1,0,0,-1,0,0,-1,0,-1,0,0,-1,0,0,-1,0,0,-1,0,0,-1,0,0,-1,0];
	}
	,__class__: libs_webgl_mesh_CubeMesh
});
var libs_webgl_mesh_ObjMesh = function(obj) {
	this.obj = obj;
	libs_webgl_mesh_Mesh.call(this);
};
libs_webgl_mesh_ObjMesh.__name__ = true;
libs_webgl_mesh_ObjMesh.__super__ = libs_webgl_mesh_Mesh;
libs_webgl_mesh_ObjMesh.prototype = $extend(libs_webgl_mesh_Mesh.prototype,{
	getTexCoords: function() {
		return this.obj.texcoord;
	}
	,getNormals: function() {
		return this.obj.normal;
	}
	,getCount: function() {
		return this.obj.position.length;
	}
	,getGLVertices: function() {
		return this.obj.position;
	}
	,__class__: libs_webgl_mesh_ObjMesh
});
var libs_webgl_mesh_PlaneMesh = function() {
	libs_webgl_mesh_Mesh.call(this);
};
libs_webgl_mesh_PlaneMesh.__name__ = true;
libs_webgl_mesh_PlaneMesh.__super__ = libs_webgl_mesh_Mesh;
libs_webgl_mesh_PlaneMesh.prototype = $extend(libs_webgl_mesh_Mesh.prototype,{
	getVertices: function() {
		return [0.5,0,0.5,0.5,0,-0.5,-0.5,0,-0.5,-0.5,0,0.5];
	}
	,getIndices: function() {
		return [0,1,3,1,2,3];
	}
	,getTexCoords: function() {
		return [1,0,1,1,0,0,1,1,0,1,0,0];
	}
	,getNormals: function() {
		return [0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0];
	}
	,__class__: libs_webgl_mesh_PlaneMesh
});
var libs_webgl_mesh_QuadMesh = function() {
	libs_webgl_mesh_Mesh.call(this);
};
libs_webgl_mesh_QuadMesh.__name__ = true;
libs_webgl_mesh_QuadMesh.__super__ = libs_webgl_mesh_Mesh;
libs_webgl_mesh_QuadMesh.prototype = $extend(libs_webgl_mesh_Mesh.prototype,{
	getVertices: function() {
		return [-1,-1,1,-1,-1,1,-1,1,1,-1,1,1];
	}
	,getBindingInfo: function() {
		var gl = libs_webgl_Engine.inst().gl;
		return [["a_vertex",2,gl.FLOAT,false,0,0,new Float32Array(this.getVertices())]];
	}
	,getCount: function() {
		return this.getVertices().length;
	}
	,getIndices: function() {
		return [];
	}
	,getTexCoords: function() {
		return [];
	}
	,__class__: libs_webgl_mesh_QuadMesh
});
var mme_math_glmatrix_GLMatrix = function() { };
mme_math_glmatrix_GLMatrix.__name__ = true;
mme_math_glmatrix_GLMatrix.toRadian = function(a) {
	return a * mme_math_glmatrix_GLMatrix.degree;
};
mme_math_glmatrix_GLMatrix.equals = function(a,b) {
	return Math.abs(a - b) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a),Math.abs(b)));
};
var mme_math_glmatrix_Mat2 = {};
mme_math_glmatrix_Mat2._new = function() {
	var this1 = new Array(4);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[0] = 1.0;
	this2[3] = 1.0;
	return this2;
};
mme_math_glmatrix_Mat2.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Mat2.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Mat2.fromArray = function(a) {
	return mme_math_glmatrix_Mat2.fromValues(null,a[0],a[1],a[2],a[3]);
};
mme_math_glmatrix_Mat2.toArray = function(this1) {
	return [this1[0],this1[1],this1[2],this1[3]];
};
mme_math_glmatrix_Mat2.toString = function(this1) {
	return mme_math_glmatrix_Mat2Tools.str(this1);
};
mme_math_glmatrix_Mat2.fromValues = function(out,m00,m01,m10,m11) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = m00;
	out[1] = m01;
	out[2] = m10;
	out[3] = m11;
	return out;
};
mme_math_glmatrix_Mat2.fromRotation = function(out,rad) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	out[0] = c;
	out[1] = s;
	var v = -s;
	out[2] = v;
	out[3] = c;
	return out;
};
mme_math_glmatrix_Mat2.fromScaling = function(out,v) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v1 = v[0];
	out[0] = v1;
	out[1] = 0;
	out[2] = 0;
	var v1 = v[1];
	out[3] = v1;
	return out;
};
var mme_math_glmatrix_Mat2Tools = function() { };
mme_math_glmatrix_Mat2Tools.__name__ = true;
mme_math_glmatrix_Mat2Tools.create = function() {
	var this1 = new Array(4);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[0] = 1.0;
	this2[3] = 1.0;
	var out = this2;
	return out;
};
mme_math_glmatrix_Mat2Tools.clone = function(a) {
	var this1 = new Array(4);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[0] = 1.0;
	this2[3] = 1.0;
	var out = this2;
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.identity = function(out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = 1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 1;
	return out;
};
mme_math_glmatrix_Mat2Tools.set = function(out,m00,m01,m10,m11) {
	out[0] = m00;
	out[1] = m01;
	out[2] = m10;
	out[3] = m11;
	return out;
};
mme_math_glmatrix_Mat2Tools.transpose = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	if(out == a) {
		var a1 = a[1];
		var v = a[2];
		out[1] = v;
		out[2] = a1;
	} else {
		var v = a[0];
		out[0] = v;
		var v = a[2];
		out[1] = v;
		var v = a[1];
		out[2] = v;
		var v = a[3];
		out[3] = v;
	}
	return out;
};
mme_math_glmatrix_Mat2Tools.invert = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var det = a0 * a3 - a2 * a1;
	if(det == 0.0) {
		return null;
	}
	det = 1.0 / det;
	var v = a3 * det;
	out[0] = v;
	var v = -a1 * det;
	out[1] = v;
	var v = -a2 * det;
	out[2] = v;
	var v = a0 * det;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.adjoint = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var v = a[3];
	out[0] = v;
	var v = -a[1];
	out[1] = v;
	var v = -a[2];
	out[2] = v;
	out[3] = a0;
	return out;
};
mme_math_glmatrix_Mat2Tools.determinant = function(a) {
	return a[0] * a[3] - a[2] * a[1];
};
mme_math_glmatrix_Mat2Tools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	var v = a0 * b0 + a2 * b1;
	out[0] = v;
	var v = a1 * b0 + a3 * b1;
	out[1] = v;
	var v = a0 * b2 + a2 * b3;
	out[2] = v;
	var v = a1 * b2 + a3 * b3;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.rotate = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	var v = a0 * c + a2 * s;
	out[0] = v;
	var v = a1 * c + a3 * s;
	out[1] = v;
	var v = a0 * -s + a2 * c;
	out[2] = v;
	var v = a1 * -s + a3 * c;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.scale = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var v0 = v[0];
	var v1 = v[1];
	var v = a0 * v0;
	out[0] = v;
	var v = a1 * v0;
	out[1] = v;
	var v = a2 * v1;
	out[2] = v;
	var v = a3 * v1;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.str = function(a) {
	return "Mat2(" + a[0] + ", " + a[1] + ", " + a[2] + ", " + a[3] + ")";
};
mme_math_glmatrix_Mat2Tools.frob = function(a) {
	return Math.sqrt(Math.pow(a[0],2) + Math.pow(a[1],2) + Math.pow(a[2],2) + Math.pow(a[3],2));
};
mme_math_glmatrix_Mat2Tools.LDU = function(a,L,D,U) {
	var v = a[2] / a[0];
	L[2] = v;
	var v = a[0];
	U[0] = v;
	var v = a[1];
	U[1] = v;
	var v = a[3] - L[2] * U[1];
	U[3] = v;
	return [L,D,U];
};
mme_math_glmatrix_Mat2Tools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	var v = a[2] + b[2];
	out[2] = v;
	var v = a[3] + b[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.subtract = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] - b[0];
	out[0] = v;
	var v = a[1] - b[1];
	out[1] = v;
	var v = a[2] - b[2];
	out[2] = v;
	var v = a[3] - b[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.exactEquals = function(a,b) {
	if(a[0] == b[0] && a[1] == b[1] && a[2] == b[2]) {
		return a[3] == b[3];
	} else {
		return false;
	}
};
mme_math_glmatrix_Mat2Tools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0))) && Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1))) && Math.abs(a2 - b2) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a2),Math.abs(b2)))) {
		return Math.abs(a3 - b3) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a3),Math.abs(b3)));
	} else {
		return false;
	}
};
mme_math_glmatrix_Mat2Tools.multiplyVec2 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var v = a[0] * x + a[2] * y;
	out[0] = v;
	var v = a[1] * x + a[3] * y;
	out[1] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.multiplyScalar = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	var v = a[2] * b;
	out[2] = v;
	var v = a[3] * b;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat2Tools.multiplyScalarAndAdd = function(a,b,scale,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0] * scale;
	out[0] = v;
	var v = a[1] + b[1] * scale;
	out[1] = v;
	var v = a[2] + b[2] * scale;
	out[2] = v;
	var v = a[3] + b[3] * scale;
	out[3] = v;
	return out;
};
var mme_math_glmatrix_Mat2d = {};
mme_math_glmatrix_Mat2d._new = function() {
	var this1 = new Array(6);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[4] = 0.0;
	this2[5] = 0.0;
	this2[0] = 1.0;
	this2[3] = 1.0;
	return this2;
};
mme_math_glmatrix_Mat2d.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Mat2d.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Mat2d.fromArray = function(a) {
	return mme_math_glmatrix_Mat2d.fromValues(null,a[0],a[1],a[2],a[3],a[4],a[5]);
};
mme_math_glmatrix_Mat2d.toArray = function(this1) {
	return [this1[0],this1[1],this1[2],this1[3],this1[4],this1[5]];
};
mme_math_glmatrix_Mat2d.toString = function(this1) {
	return mme_math_glmatrix_Mat2dTools.str(this1);
};
mme_math_glmatrix_Mat2d.fromValues = function(out,a,b,c,d,tx,ty) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = a;
	out[1] = b;
	out[2] = c;
	out[3] = d;
	out[4] = tx;
	out[5] = ty;
	return out;
};
mme_math_glmatrix_Mat2d.fromRotation = function(out,rad) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	out[0] = c;
	out[1] = s;
	var v = -s;
	out[2] = v;
	out[3] = c;
	out[4] = 0;
	out[5] = 0;
	return out;
};
mme_math_glmatrix_Mat2d.fromScaling = function(out,v) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v1 = v[0];
	out[0] = v1;
	out[1] = 0;
	out[2] = 0;
	var v1 = v[1];
	out[3] = v1;
	out[4] = 0;
	out[5] = 0;
	return out;
};
mme_math_glmatrix_Mat2d.fromTranslation = function(out,v) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = 1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 1;
	var v1 = v[0];
	out[4] = v1;
	var v1 = v[1];
	out[5] = v1;
	return out;
};
var mme_math_glmatrix_Mat2dTools = function() { };
mme_math_glmatrix_Mat2dTools.__name__ = true;
mme_math_glmatrix_Mat2dTools.create = function() {
	var this1 = new Array(6);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[4] = 0.0;
	this2[5] = 0.0;
	this2[0] = 1.0;
	this2[3] = 1.0;
	var out = this2;
	return out;
};
mme_math_glmatrix_Mat2dTools.clone = function(a) {
	var this1 = new Array(6);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[4] = 0.0;
	this2[5] = 0.0;
	this2[0] = 1.0;
	this2[3] = 1.0;
	var out = this2;
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	var v = a[4];
	out[4] = v;
	var v = a[5];
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	var v = a[4];
	out[4] = v;
	var v = a[5];
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.identity = function(out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = 1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 1;
	out[4] = 0;
	out[5] = 0;
	return out;
};
mme_math_glmatrix_Mat2dTools.set = function(out,a,b,c,d,tx,ty) {
	out[0] = a;
	out[1] = b;
	out[2] = c;
	out[3] = d;
	out[4] = tx;
	out[5] = ty;
	return out;
};
mme_math_glmatrix_Mat2dTools.invert = function(a,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var aa = a[0];
	var ab = a[1];
	var ac = a[2];
	var ad = a[3];
	var atx = a[4];
	var aty = a[5];
	var det = aa * ad - ab * ac;
	if(det == 0.0) {
		return null;
	}
	det = 1.0 / det;
	var v = ad * det;
	out[0] = v;
	var v = -ab * det;
	out[1] = v;
	var v = -ac * det;
	out[2] = v;
	var v = aa * det;
	out[3] = v;
	var v = (ac * aty - ad * atx) * det;
	out[4] = v;
	var v = (ab * atx - aa * aty) * det;
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.determinant = function(a) {
	return a[0] * a[3] - a[1] * a[2];
};
mme_math_glmatrix_Mat2dTools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var a4 = a[4];
	var a5 = a[5];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	var b4 = b[4];
	var b5 = b[5];
	var v = a0 * b0 + a2 * b1;
	out[0] = v;
	var v = a1 * b0 + a3 * b1;
	out[1] = v;
	var v = a0 * b2 + a2 * b3;
	out[2] = v;
	var v = a1 * b2 + a3 * b3;
	out[3] = v;
	var v = a0 * b4 + a2 * b5 + a4;
	out[4] = v;
	var v = a1 * b4 + a3 * b5 + a5;
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.rotate = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var a4 = a[4];
	var a5 = a[5];
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	var v = a0 * c + a2 * s;
	out[0] = v;
	var v = a1 * c + a3 * s;
	out[1] = v;
	var v = a0 * -s + a2 * c;
	out[2] = v;
	var v = a1 * -s + a3 * c;
	out[3] = v;
	out[4] = a4;
	out[5] = a5;
	return out;
};
mme_math_glmatrix_Mat2dTools.scale = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var a4 = a[4];
	var a5 = a[5];
	var v0 = v[0];
	var v1 = v[1];
	var v = a0 * v0;
	out[0] = v;
	var v = a1 * v0;
	out[1] = v;
	var v = a2 * v1;
	out[2] = v;
	var v = a3 * v1;
	out[3] = v;
	out[4] = a4;
	out[5] = a5;
	return out;
};
mme_math_glmatrix_Mat2dTools.translate = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var a4 = a[4];
	var a5 = a[5];
	var v0 = v[0];
	var v1 = v[1];
	out[0] = a0;
	out[1] = a1;
	out[2] = a2;
	out[3] = a3;
	var v = a0 * v0 + a2 * v1 + a4;
	out[4] = v;
	var v = a1 * v0 + a3 * v1 + a5;
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.str = function(a) {
	return "Mat2d(" + a[0] + ", " + a[1] + ", " + a[2] + ", " + a[3] + ", " + a[4] + ", " + a[5] + ")";
};
mme_math_glmatrix_Mat2dTools.frob = function(a) {
	return Math.sqrt(Math.pow(a[0],2) + Math.pow(a[1],2) + Math.pow(a[2],2) + Math.pow(a[3],2) + Math.pow(a[4],2) + Math.pow(a[5],2) + 1);
};
mme_math_glmatrix_Mat2dTools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	var v = a[2] + b[2];
	out[2] = v;
	var v = a[3] + b[3];
	out[3] = v;
	var v = a[4] + b[4];
	out[4] = v;
	var v = a[5] + b[5];
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.subtract = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] - b[0];
	out[0] = v;
	var v = a[1] - b[1];
	out[1] = v;
	var v = a[2] - b[2];
	out[2] = v;
	var v = a[3] - b[3];
	out[3] = v;
	var v = a[4] - b[4];
	out[4] = v;
	var v = a[5] - b[5];
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.multiplyVec2 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var v = a[0] * x + a[2] * y + a[4];
	out[0] = v;
	var v = a[1] * x + a[3] * y + a[5];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.multiplyScalar = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	var v = a[2] * b;
	out[2] = v;
	var v = a[3] * b;
	out[3] = v;
	var v = a[4] * b;
	out[4] = v;
	var v = a[5] * b;
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.multiplyScalarAndAdd = function(a,b,scale,out) {
	if(out == null) {
		var this1 = new Array(6);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[0] = 1.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0] * scale;
	out[0] = v;
	var v = a[1] + b[1] * scale;
	out[1] = v;
	var v = a[2] + b[2] * scale;
	out[2] = v;
	var v = a[3] + b[3] * scale;
	out[3] = v;
	var v = a[4] + b[4] * scale;
	out[4] = v;
	var v = a[5] + b[5] * scale;
	out[5] = v;
	return out;
};
mme_math_glmatrix_Mat2dTools.exactEquals = function(a,b) {
	if(a[0] == b[0] && a[1] == b[1] && a[2] == b[2] && a[3] == b[3] && a[4] == b[4]) {
		return a[5] == b[5];
	} else {
		return false;
	}
};
mme_math_glmatrix_Mat2dTools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var a4 = a[4];
	var a5 = a[5];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	var b4 = b[4];
	var b5 = b[5];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0))) && Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1))) && Math.abs(a2 - b2) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a2),Math.abs(b2))) && Math.abs(a3 - b3) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a3),Math.abs(b3))) && Math.abs(a4 - b4) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a4),Math.abs(b4)))) {
		return Math.abs(a5 - b5) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a5),Math.abs(b5)));
	} else {
		return false;
	}
};
var mme_math_glmatrix_Mat3 = {};
mme_math_glmatrix_Mat3._new = function() {
	var this1 = new Array(9);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	this2[5] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[0] = 1.0;
	this2[4] = 1.0;
	this2[8] = 1.0;
	return this2;
};
mme_math_glmatrix_Mat3.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Mat3.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Mat3.fromArray = function(a) {
	return mme_math_glmatrix_Mat3.fromValues(null,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8]);
};
mme_math_glmatrix_Mat3.toArray = function(this1) {
	return [this1[0],this1[1],this1[2],this1[3],this1[4],this1[5],this1[6],this1[7],this1[8]];
};
mme_math_glmatrix_Mat3.toString = function(this1) {
	return mme_math_glmatrix_Mat3Tools.str(this1);
};
mme_math_glmatrix_Mat3.fromValues = function(out,m00,m01,m02,m10,m11,m12,m20,m21,m22) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = m00;
	out[1] = m01;
	out[2] = m02;
	out[3] = m10;
	out[4] = m11;
	out[5] = m12;
	out[6] = m20;
	out[7] = m21;
	out[8] = m22;
	return out;
};
mme_math_glmatrix_Mat3.fromMat4 = function(out,a) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[4];
	out[3] = v;
	var v = a[5];
	out[4] = v;
	var v = a[6];
	out[5] = v;
	var v = a[8];
	out[6] = v;
	var v = a[9];
	out[7] = v;
	var v = a[10];
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3.fromTranslation = function(out,v) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = 1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 1;
	out[5] = 0;
	var v1 = v[0];
	out[6] = v1;
	var v1 = v[1];
	out[7] = v1;
	out[8] = 1;
	return out;
};
mme_math_glmatrix_Mat3.fromRotation = function(out,rad) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	out[0] = c;
	out[1] = s;
	out[2] = 0;
	var v = -s;
	out[3] = v;
	out[4] = c;
	out[5] = 0;
	out[6] = 0;
	out[7] = 0;
	out[8] = 1;
	return out;
};
mme_math_glmatrix_Mat3.fromScaling = function(out,v) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v1 = v[0];
	out[0] = v1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	var v1 = v[1];
	out[4] = v1;
	out[5] = 0;
	out[6] = 0;
	out[7] = 0;
	out[8] = 1;
	return out;
};
mme_math_glmatrix_Mat3.fromMat2d = function(out,a) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	out[2] = 0;
	var v = a[2];
	out[3] = v;
	var v = a[3];
	out[4] = v;
	out[5] = 0;
	var v = a[4];
	out[6] = v;
	var v = a[5];
	out[7] = v;
	out[8] = 1;
	return out;
};
mme_math_glmatrix_Mat3.fromQuat = function(out,q) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = q[0];
	var y = q[1];
	var z = q[2];
	var w = q[3];
	var x2 = x + x;
	var y2 = y + y;
	var z2 = z + z;
	var xx = x * x2;
	var yx = y * x2;
	var yy = y * y2;
	var zx = z * x2;
	var zy = z * y2;
	var zz = z * z2;
	var wx = w * x2;
	var wy = w * y2;
	var wz = w * z2;
	var v = 1 - yy - zz;
	out[0] = v;
	var v = yx - wz;
	out[3] = v;
	var v = zx + wy;
	out[6] = v;
	var v = yx + wz;
	out[1] = v;
	var v = 1 - xx - zz;
	out[4] = v;
	var v = zy - wx;
	out[7] = v;
	var v = zx - wy;
	out[2] = v;
	var v = zy + wx;
	out[5] = v;
	var v = 1 - xx - yy;
	out[8] = v;
	return out;
};
var mme_math_glmatrix_Mat3Tools = function() { };
mme_math_glmatrix_Mat3Tools.__name__ = true;
mme_math_glmatrix_Mat3Tools.create = function() {
	var this1 = new Array(9);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	this2[5] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[0] = 1.0;
	this2[4] = 1.0;
	this2[8] = 1.0;
	var out = this2;
	return out;
};
mme_math_glmatrix_Mat3Tools.clone = function(a) {
	var this1 = new Array(9);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	this2[5] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[0] = 1.0;
	this2[4] = 1.0;
	this2[8] = 1.0;
	var out = this2;
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	var v = a[4];
	out[4] = v;
	var v = a[5];
	out[5] = v;
	var v = a[6];
	out[6] = v;
	var v = a[7];
	out[7] = v;
	var v = a[8];
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	var v = a[4];
	out[4] = v;
	var v = a[5];
	out[5] = v;
	var v = a[6];
	out[6] = v;
	var v = a[7];
	out[7] = v;
	var v = a[8];
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.set = function(out,m00,m01,m02,m10,m11,m12,m20,m21,m22) {
	out[0] = m00;
	out[1] = m01;
	out[2] = m02;
	out[3] = m10;
	out[4] = m11;
	out[5] = m12;
	out[6] = m20;
	out[7] = m21;
	out[8] = m22;
	return out;
};
mme_math_glmatrix_Mat3Tools.identity = function(out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = 1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 1;
	out[5] = 0;
	out[6] = 0;
	out[7] = 0;
	out[8] = 1;
	return out;
};
mme_math_glmatrix_Mat3Tools.transpose = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	if(out == a) {
		var a01 = a[1];
		var a02 = a[2];
		var a12 = a[5];
		var v = a[3];
		out[1] = v;
		var v = a[6];
		out[2] = v;
		out[3] = a01;
		var v = a[7];
		out[5] = v;
		out[6] = a02;
		out[7] = a12;
	} else {
		var v = a[0];
		out[0] = v;
		var v = a[3];
		out[1] = v;
		var v = a[6];
		out[2] = v;
		var v = a[1];
		out[3] = v;
		var v = a[4];
		out[4] = v;
		var v = a[7];
		out[5] = v;
		var v = a[2];
		out[6] = v;
		var v = a[5];
		out[7] = v;
		var v = a[8];
		out[8] = v;
	}
	return out;
};
mme_math_glmatrix_Mat3Tools.invert = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a10 = a[3];
	var a11 = a[4];
	var a12 = a[5];
	var a20 = a[6];
	var a21 = a[7];
	var a22 = a[8];
	var b01 = a22 * a11 - a12 * a21;
	var b11 = -a22 * a10 + a12 * a20;
	var b21 = a21 * a10 - a11 * a20;
	var det = a00 * b01 + a01 * b11 + a02 * b21;
	if(det == 0.0) {
		return null;
	}
	det = 1.0 / det;
	var v = b01 * det;
	out[0] = v;
	var v = (-a22 * a01 + a02 * a21) * det;
	out[1] = v;
	var v = (a12 * a01 - a02 * a11) * det;
	out[2] = v;
	var v = b11 * det;
	out[3] = v;
	var v = (a22 * a00 - a02 * a20) * det;
	out[4] = v;
	var v = (-a12 * a00 + a02 * a10) * det;
	out[5] = v;
	var v = b21 * det;
	out[6] = v;
	var v = (-a21 * a00 + a01 * a20) * det;
	out[7] = v;
	var v = (a11 * a00 - a01 * a10) * det;
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.adjoint = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a10 = a[3];
	var a11 = a[4];
	var a12 = a[5];
	var a20 = a[6];
	var a21 = a[7];
	var a22 = a[8];
	var v = a11 * a22 - a12 * a21;
	out[0] = v;
	var v = a02 * a21 - a01 * a22;
	out[1] = v;
	var v = a01 * a12 - a02 * a11;
	out[2] = v;
	var v = a12 * a20 - a10 * a22;
	out[3] = v;
	var v = a00 * a22 - a02 * a20;
	out[4] = v;
	var v = a02 * a10 - a00 * a12;
	out[5] = v;
	var v = a10 * a21 - a11 * a20;
	out[6] = v;
	var v = a01 * a20 - a00 * a21;
	out[7] = v;
	var v = a00 * a11 - a01 * a10;
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.determinant = function(a) {
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a10 = a[3];
	var a11 = a[4];
	var a12 = a[5];
	var a20 = a[6];
	var a21 = a[7];
	var a22 = a[8];
	return a00 * (a22 * a11 - a12 * a21) + a01 * (-a22 * a10 + a12 * a20) + a02 * (a21 * a10 - a11 * a20);
};
mme_math_glmatrix_Mat3Tools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a10 = a[3];
	var a11 = a[4];
	var a12 = a[5];
	var a20 = a[6];
	var a21 = a[7];
	var a22 = a[8];
	var b00 = b[0];
	var b01 = b[1];
	var b02 = b[2];
	var b10 = b[3];
	var b11 = b[4];
	var b12 = b[5];
	var b20 = b[6];
	var b21 = b[7];
	var b22 = b[8];
	var v = b00 * a00 + b01 * a10 + b02 * a20;
	out[0] = v;
	var v = b00 * a01 + b01 * a11 + b02 * a21;
	out[1] = v;
	var v = b00 * a02 + b01 * a12 + b02 * a22;
	out[2] = v;
	var v = b10 * a00 + b11 * a10 + b12 * a20;
	out[3] = v;
	var v = b10 * a01 + b11 * a11 + b12 * a21;
	out[4] = v;
	var v = b10 * a02 + b11 * a12 + b12 * a22;
	out[5] = v;
	var v = b20 * a00 + b21 * a10 + b22 * a20;
	out[6] = v;
	var v = b20 * a01 + b21 * a11 + b22 * a21;
	out[7] = v;
	var v = b20 * a02 + b21 * a12 + b22 * a22;
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.translate = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a10 = a[3];
	var a11 = a[4];
	var a12 = a[5];
	var a20 = a[6];
	var a21 = a[7];
	var a22 = a[8];
	var x = v[0];
	var y = v[1];
	out[0] = a00;
	out[1] = a01;
	out[2] = a02;
	out[3] = a10;
	out[4] = a11;
	out[5] = a12;
	var v = x * a00 + y * a10 + a20;
	out[6] = v;
	var v = x * a01 + y * a11 + a21;
	out[7] = v;
	var v = x * a02 + y * a12 + a22;
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.rotate = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a10 = a[3];
	var a11 = a[4];
	var a12 = a[5];
	var a20 = a[6];
	var a21 = a[7];
	var a22 = a[8];
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	var v = c * a00 + s * a10;
	out[0] = v;
	var v = c * a01 + s * a11;
	out[1] = v;
	var v = c * a02 + s * a12;
	out[2] = v;
	var v = c * a10 - s * a00;
	out[3] = v;
	var v = c * a11 - s * a01;
	out[4] = v;
	var v = c * a12 - s * a02;
	out[5] = v;
	out[6] = a20;
	out[7] = a21;
	out[8] = a22;
	return out;
};
mme_math_glmatrix_Mat3Tools.scale = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var v = x * a[0];
	out[0] = v;
	var v = x * a[1];
	out[1] = v;
	var v = x * a[2];
	out[2] = v;
	var v = y * a[3];
	out[3] = v;
	var v = y * a[4];
	out[4] = v;
	var v = y * a[5];
	out[5] = v;
	var v = a[6];
	out[6] = v;
	var v = a[7];
	out[7] = v;
	var v = a[8];
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.normalFromMat4 = function(out,a) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a03 = a[3];
	var a10 = a[4];
	var a11 = a[5];
	var a12 = a[6];
	var a13 = a[7];
	var a20 = a[8];
	var a21 = a[9];
	var a22 = a[10];
	var a23 = a[11];
	var a30 = a[12];
	var a31 = a[13];
	var a32 = a[14];
	var a33 = a[15];
	var b00 = a00 * a11 - a01 * a10;
	var b01 = a00 * a12 - a02 * a10;
	var b02 = a00 * a13 - a03 * a10;
	var b03 = a01 * a12 - a02 * a11;
	var b04 = a01 * a13 - a03 * a11;
	var b05 = a02 * a13 - a03 * a12;
	var b06 = a20 * a31 - a21 * a30;
	var b07 = a20 * a32 - a22 * a30;
	var b08 = a20 * a33 - a23 * a30;
	var b09 = a21 * a32 - a22 * a31;
	var b10 = a21 * a33 - a23 * a31;
	var b11 = a22 * a33 - a23 * a32;
	var det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;
	if(det == 0.0) {
		return null;
	}
	det = 1.0 / det;
	var v = (a11 * b11 - a12 * b10 + a13 * b09) * det;
	out[0] = v;
	var v = (a12 * b08 - a10 * b11 - a13 * b07) * det;
	out[1] = v;
	var v = (a10 * b10 - a11 * b08 + a13 * b06) * det;
	out[2] = v;
	var v = (a02 * b10 - a01 * b11 - a03 * b09) * det;
	out[3] = v;
	var v = (a00 * b11 - a02 * b08 + a03 * b07) * det;
	out[4] = v;
	var v = (a01 * b08 - a00 * b10 - a03 * b06) * det;
	out[5] = v;
	var v = (a31 * b05 - a32 * b04 + a33 * b03) * det;
	out[6] = v;
	var v = (a32 * b02 - a30 * b05 - a33 * b01) * det;
	out[7] = v;
	var v = (a30 * b04 - a31 * b02 + a33 * b00) * det;
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.projection = function(width,height,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = 2 / width;
	out[0] = v;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	var v = -2 / height;
	out[4] = v;
	out[5] = 0;
	out[6] = -1;
	out[7] = 1;
	out[8] = 1;
	return out;
};
mme_math_glmatrix_Mat3Tools.str = function(a) {
	return "Mat3(" + a[0] + ", " + a[1] + ", " + a[2] + ", " + a[3] + ", " + a[4] + ", " + a[5] + ", " + a[6] + ", " + a[7] + ", " + a[8] + ")";
};
mme_math_glmatrix_Mat3Tools.frob = function(a) {
	return Math.sqrt(Math.pow(a[0],2) + Math.pow(a[1],2) + Math.pow(a[2],2) + Math.pow(a[3],2) + Math.pow(a[4],2) + Math.pow(a[5],2) + Math.pow(a[6],2) + Math.pow(a[7],2) + Math.pow(a[8],2));
};
mme_math_glmatrix_Mat3Tools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	var v = a[2] + b[2];
	out[2] = v;
	var v = a[3] + b[3];
	out[3] = v;
	var v = a[4] + b[4];
	out[4] = v;
	var v = a[5] + b[5];
	out[5] = v;
	var v = a[6] + b[6];
	out[6] = v;
	var v = a[7] + b[7];
	out[7] = v;
	var v = a[8] + b[8];
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.subtract = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] - b[0];
	out[0] = v;
	var v = a[1] - b[1];
	out[1] = v;
	var v = a[2] - b[2];
	out[2] = v;
	var v = a[3] - b[3];
	out[3] = v;
	var v = a[4] - b[4];
	out[4] = v;
	var v = a[5] - b[5];
	out[5] = v;
	var v = a[6] - b[6];
	out[6] = v;
	var v = a[7] - b[7];
	out[7] = v;
	var v = a[8] - b[8];
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.multiplyVec3 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var z = v[2];
	var v = x * a[0] + y * a[3] + z * a[6];
	out[0] = v;
	var v = x * a[1] + y * a[4] + z * a[7];
	out[1] = v;
	var v = x * a[2] + y * a[5] + z * a[8];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.multiplyVec2 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var v = a[0] * x + a[3] * y + a[6];
	out[0] = v;
	var v = a[1] * x + a[4] * y + a[7];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.multiplyScalar = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	var v = a[2] * b;
	out[2] = v;
	var v = a[3] * b;
	out[3] = v;
	var v = a[4] * b;
	out[4] = v;
	var v = a[5] * b;
	out[5] = v;
	var v = a[6] * b;
	out[6] = v;
	var v = a[7] * b;
	out[7] = v;
	var v = a[8] * b;
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.multiplyScalarAndAdd = function(a,b,scale,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[0] = 1.0;
		this2[4] = 1.0;
		this2[8] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0] * scale;
	out[0] = v;
	var v = a[1] + b[1] * scale;
	out[1] = v;
	var v = a[2] + b[2] * scale;
	out[2] = v;
	var v = a[3] + b[3] * scale;
	out[3] = v;
	var v = a[4] + b[4] * scale;
	out[4] = v;
	var v = a[5] + b[5] * scale;
	out[5] = v;
	var v = a[6] + b[6] * scale;
	out[6] = v;
	var v = a[7] + b[7] * scale;
	out[7] = v;
	var v = a[8] + b[8] * scale;
	out[8] = v;
	return out;
};
mme_math_glmatrix_Mat3Tools.exactEquals = function(a,b) {
	if(a[0] == b[0] && a[1] == b[1] && a[2] == b[2] && a[3] == b[3] && a[4] == b[4] && a[5] == b[5] && a[6] == b[6] && a[7] == b[7]) {
		return a[8] == b[8];
	} else {
		return false;
	}
};
mme_math_glmatrix_Mat3Tools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var a4 = a[4];
	var a5 = a[5];
	var a6 = a[6];
	var a7 = a[7];
	var a8 = a[8];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	var b4 = b[4];
	var b5 = b[5];
	var b6 = b[6];
	var b7 = b[7];
	var b8 = b[8];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0))) && Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1))) && Math.abs(a2 - b2) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a2),Math.abs(b2))) && Math.abs(a3 - b3) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a3),Math.abs(b3))) && Math.abs(a4 - b4) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a4),Math.abs(b4))) && Math.abs(a5 - b5) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a5),Math.abs(b5))) && Math.abs(a6 - b6) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a6),Math.abs(b6))) && Math.abs(a7 - b7) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a7),Math.abs(b7)))) {
		return Math.abs(a8 - b8) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a8),Math.abs(b8)));
	} else {
		return false;
	}
};
var mme_math_glmatrix_Mat4 = {};
mme_math_glmatrix_Mat4._new = function() {
	var this1 = new Array(16);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	this2[4] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[8] = 0.0;
	this2[9] = 0.0;
	this2[11] = 0.0;
	this2[12] = 0.0;
	this2[13] = 0.0;
	this2[14] = 0.0;
	this2[0] = 1.0;
	this2[5] = 1.0;
	this2[10] = 1.0;
	this2[15] = 1.0;
	return this2;
};
mme_math_glmatrix_Mat4.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Mat4.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Mat4.fromArray = function(a) {
	return mme_math_glmatrix_Mat4.fromValues(null,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15]);
};
mme_math_glmatrix_Mat4.toArray = function(this1) {
	return [this1[0],this1[1],this1[2],this1[3],this1[4],this1[5],this1[6],this1[7],this1[8],this1[9],this1[10],this1[11],this1[12],this1[13],this1[14],this1[15]];
};
mme_math_glmatrix_Mat4.toString = function(this1) {
	return mme_math_glmatrix_Mat4Tools.str(this1);
};
mme_math_glmatrix_Mat4.fromValues = function(out,m00,m01,m02,m03,m10,m11,m12,m13,m20,m21,m22,m23,m30,m31,m32,m33) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = m00;
	out[1] = m01;
	out[2] = m02;
	out[3] = m03;
	out[4] = m10;
	out[5] = m11;
	out[6] = m12;
	out[7] = m13;
	out[8] = m20;
	out[9] = m21;
	out[10] = m22;
	out[11] = m23;
	out[12] = m30;
	out[13] = m31;
	out[14] = m32;
	out[15] = m33;
	return out;
};
mme_math_glmatrix_Mat4.fromTranslation = function(out,v) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = 1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 0;
	out[5] = 1;
	out[6] = 0;
	out[7] = 0;
	out[8] = 0;
	out[9] = 0;
	out[10] = 1;
	out[11] = 0;
	var v1 = v[0];
	out[12] = v1;
	var v1 = v[1];
	out[13] = v1;
	var v1 = v[2];
	out[14] = v1;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromScaling = function(out,v) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v1 = v[0];
	out[0] = v1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 0;
	var v1 = v[1];
	out[5] = v1;
	out[6] = 0;
	out[7] = 0;
	out[8] = 0;
	out[9] = 0;
	var v1 = v[2];
	out[10] = v1;
	out[11] = 0;
	out[12] = 0;
	out[13] = 0;
	out[14] = 0;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromRotation = function(out,rad,axis) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = axis[0];
	var y = axis[1];
	var z = axis[2];
	var len = Math.sqrt(x * x + y * y + z * z);
	if(len < 0.000001) {
		return null;
	}
	len = 1 / len;
	x *= len;
	y *= len;
	z *= len;
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	var t = 1 - c;
	var v = x * x * t + c;
	out[0] = v;
	var v = y * x * t + z * s;
	out[1] = v;
	var v = z * x * t - y * s;
	out[2] = v;
	out[3] = 0;
	var v = x * y * t - z * s;
	out[4] = v;
	var v = y * y * t + c;
	out[5] = v;
	var v = z * y * t + x * s;
	out[6] = v;
	out[7] = 0;
	var v = x * z * t + y * s;
	out[8] = v;
	var v = y * z * t - x * s;
	out[9] = v;
	var v = z * z * t + c;
	out[10] = v;
	out[11] = 0;
	out[12] = 0;
	out[13] = 0;
	out[14] = 0;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromXRotation = function(out,rad) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	out[0] = 1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 0;
	out[5] = c;
	out[6] = s;
	out[7] = 0;
	out[8] = 0;
	var v = -s;
	out[9] = v;
	out[10] = c;
	out[11] = 0;
	out[12] = 0;
	out[13] = 0;
	out[14] = 0;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromYRotation = function(out,rad) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	out[0] = c;
	out[1] = 0;
	var v = -s;
	out[2] = v;
	out[3] = 0;
	out[4] = 0;
	out[5] = 1;
	out[6] = 0;
	out[7] = 0;
	out[8] = s;
	out[9] = 0;
	out[10] = c;
	out[11] = 0;
	out[12] = 0;
	out[13] = 0;
	out[14] = 0;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromZRotation = function(out,rad) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	out[0] = c;
	out[1] = s;
	out[2] = 0;
	out[3] = 0;
	var v = -s;
	out[4] = v;
	out[5] = c;
	out[6] = 0;
	out[7] = 0;
	out[8] = 0;
	out[9] = 0;
	out[10] = 1;
	out[11] = 0;
	out[12] = 0;
	out[13] = 0;
	out[14] = 0;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromRotationTranslation = function(out,q,v) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = q[0];
	var y = q[1];
	var z = q[2];
	var w = q[3];
	var x2 = x + x;
	var y2 = y + y;
	var z2 = z + z;
	var xx = x * x2;
	var xy = x * y2;
	var xz = x * z2;
	var yy = y * y2;
	var yz = y * z2;
	var zz = z * z2;
	var wx = w * x2;
	var wy = w * y2;
	var wz = w * z2;
	var v1 = 1 - (yy + zz);
	out[0] = v1;
	var v1 = xy + wz;
	out[1] = v1;
	var v1 = xz - wy;
	out[2] = v1;
	out[3] = 0;
	var v1 = xy - wz;
	out[4] = v1;
	var v1 = 1 - (xx + zz);
	out[5] = v1;
	var v1 = yz + wx;
	out[6] = v1;
	out[7] = 0;
	var v1 = xz + wy;
	out[8] = v1;
	var v1 = yz - wx;
	out[9] = v1;
	var v1 = 1 - (xx + yy);
	out[10] = v1;
	out[11] = 0;
	var v1 = v[0];
	out[12] = v1;
	var v1 = v[1];
	out[13] = v1;
	var v1 = v[2];
	out[14] = v1;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromQuat2 = function(out,a) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var this1 = new Array(3);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	var translation = this2;
	var bx = -a[0];
	var by = -a[1];
	var bz = -a[2];
	var bw = a[3];
	var ax = a[4];
	var ay = a[5];
	var az = a[6];
	var aw = a[7];
	var magnitude = bx * bx + by * by + bz * bz + bw * bw;
	if(magnitude > 0) {
		var v = (ax * bw + aw * bx + ay * bz - az * by) * 2 / magnitude;
		translation[0] = v;
		var v = (ay * bw + aw * by + az * bx - ax * bz) * 2 / magnitude;
		translation[1] = v;
		var v = (az * bw + aw * bz + ax * by - ay * bx) * 2 / magnitude;
		translation[2] = v;
	} else {
		var v = (ax * bw + aw * bx + ay * bz - az * by) * 2;
		translation[0] = v;
		var v = (ay * bw + aw * by + az * bx - ax * bz) * 2;
		translation[1] = v;
		var v = (az * bw + aw * bz + ax * by - ay * bx) * 2;
		translation[2] = v;
	}
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 1.0;
	var out1 = this2;
	var a_r = out1;
	mme_math_glmatrix_Quat2Tools.getReal(a,a_r);
	mme_math_glmatrix_Mat4.fromRotationTranslation(out,a_r,translation);
	return out;
};
mme_math_glmatrix_Mat4.fromRotationTranslationScale = function(out,q,v,s) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = q[0];
	var y = q[1];
	var z = q[2];
	var w = q[3];
	var x2 = x + x;
	var y2 = y + y;
	var z2 = z + z;
	var xx = x * x2;
	var xy = x * y2;
	var xz = x * z2;
	var yy = y * y2;
	var yz = y * z2;
	var zz = z * z2;
	var wx = w * x2;
	var wy = w * y2;
	var wz = w * z2;
	var sx = s[0];
	var sy = s[1];
	var sz = s[2];
	var v1 = (1 - (yy + zz)) * sx;
	out[0] = v1;
	var v1 = (xy + wz) * sx;
	out[1] = v1;
	var v1 = (xz - wy) * sx;
	out[2] = v1;
	out[3] = 0;
	var v1 = (xy - wz) * sy;
	out[4] = v1;
	var v1 = (1 - (xx + zz)) * sy;
	out[5] = v1;
	var v1 = (yz + wx) * sy;
	out[6] = v1;
	out[7] = 0;
	var v1 = (xz + wy) * sz;
	out[8] = v1;
	var v1 = (yz - wx) * sz;
	out[9] = v1;
	var v1 = (1 - (xx + yy)) * sz;
	out[10] = v1;
	out[11] = 0;
	var v1 = v[0];
	out[12] = v1;
	var v1 = v[1];
	out[13] = v1;
	var v1 = v[2];
	out[14] = v1;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromRotationTranslationScaleOrigin = function(out,q,v,s,o) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = q[0];
	var y = q[1];
	var z = q[2];
	var w = q[3];
	var x2 = x + x;
	var y2 = y + y;
	var z2 = z + z;
	var xx = x * x2;
	var xy = x * y2;
	var xz = x * z2;
	var yy = y * y2;
	var yz = y * z2;
	var zz = z * z2;
	var wx = w * x2;
	var wy = w * y2;
	var wz = w * z2;
	var sx = s[0];
	var sy = s[1];
	var sz = s[2];
	var ox = o[0];
	var oy = o[1];
	var oz = o[2];
	var out0 = (1 - (yy + zz)) * sx;
	var out1 = (xy + wz) * sx;
	var out2 = (xz - wy) * sx;
	var out4 = (xy - wz) * sy;
	var out5 = (1 - (xx + zz)) * sy;
	var out6 = (yz + wx) * sy;
	var out8 = (xz + wy) * sz;
	var out9 = (yz - wx) * sz;
	var out10 = (1 - (xx + yy)) * sz;
	out[0] = out0;
	out[1] = out1;
	out[2] = out2;
	out[3] = 0;
	out[4] = out4;
	out[5] = out5;
	out[6] = out6;
	out[7] = 0;
	out[8] = out8;
	out[9] = out9;
	out[10] = out10;
	out[11] = 0;
	var v1 = v[0] + ox - (out0 * ox + out4 * oy + out8 * oz);
	out[12] = v1;
	var v1 = v[1] + oy - (out1 * ox + out5 * oy + out9 * oz);
	out[13] = v1;
	var v1 = v[2] + oz - (out2 * ox + out6 * oy + out10 * oz);
	out[14] = v1;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromQuat = function(out,q) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = q[0];
	var y = q[1];
	var z = q[2];
	var w = q[3];
	var x2 = x + x;
	var y2 = y + y;
	var z2 = z + z;
	var xx = x * x2;
	var yx = y * x2;
	var yy = y * y2;
	var zx = z * x2;
	var zy = z * y2;
	var zz = z * z2;
	var wx = w * x2;
	var wy = w * y2;
	var wz = w * z2;
	var v = 1 - yy - zz;
	out[0] = v;
	var v = yx + wz;
	out[1] = v;
	var v = zx - wy;
	out[2] = v;
	out[3] = 0;
	var v = yx - wz;
	out[4] = v;
	var v = 1 - xx - zz;
	out[5] = v;
	var v = zy + wx;
	out[6] = v;
	out[7] = 0;
	var v = zx + wy;
	out[8] = v;
	var v = zy - wx;
	out[9] = v;
	var v = 1 - xx - yy;
	out[10] = v;
	out[11] = 0;
	out[12] = 0;
	out[13] = 0;
	out[14] = 0;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4.fromMat3 = function(out,a) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[4] = v;
	var v = a[4];
	out[5] = v;
	var v = a[5];
	out[6] = v;
	var v = a[6];
	out[8] = v;
	var v = a[7];
	out[9] = v;
	var v = a[8];
	out[10] = v;
	return out;
};
var mme_math_glmatrix_Mat4Tools = function() { };
mme_math_glmatrix_Mat4Tools.__name__ = true;
mme_math_glmatrix_Mat4Tools.create = function() {
	var this1 = new Array(16);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	this2[4] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[8] = 0.0;
	this2[9] = 0.0;
	this2[11] = 0.0;
	this2[12] = 0.0;
	this2[13] = 0.0;
	this2[14] = 0.0;
	this2[0] = 1.0;
	this2[5] = 1.0;
	this2[10] = 1.0;
	this2[15] = 1.0;
	var out = this2;
	return out;
};
mme_math_glmatrix_Mat4Tools.clone = function(a) {
	var this1 = new Array(16);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	this2[4] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[8] = 0.0;
	this2[9] = 0.0;
	this2[11] = 0.0;
	this2[12] = 0.0;
	this2[13] = 0.0;
	this2[14] = 0.0;
	this2[0] = 1.0;
	this2[5] = 1.0;
	this2[10] = 1.0;
	this2[15] = 1.0;
	var out = this2;
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	var v = a[4];
	out[4] = v;
	var v = a[5];
	out[5] = v;
	var v = a[6];
	out[6] = v;
	var v = a[7];
	out[7] = v;
	var v = a[8];
	out[8] = v;
	var v = a[9];
	out[9] = v;
	var v = a[10];
	out[10] = v;
	var v = a[11];
	out[11] = v;
	var v = a[12];
	out[12] = v;
	var v = a[13];
	out[13] = v;
	var v = a[14];
	out[14] = v;
	var v = a[15];
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	var v = a[4];
	out[4] = v;
	var v = a[5];
	out[5] = v;
	var v = a[6];
	out[6] = v;
	var v = a[7];
	out[7] = v;
	var v = a[8];
	out[8] = v;
	var v = a[9];
	out[9] = v;
	var v = a[10];
	out[10] = v;
	var v = a[11];
	out[11] = v;
	var v = a[12];
	out[12] = v;
	var v = a[13];
	out[13] = v;
	var v = a[14];
	out[14] = v;
	var v = a[15];
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.set = function(out,m00,m01,m02,m03,m10,m11,m12,m13,m20,m21,m22,m23,m30,m31,m32,m33) {
	out[0] = m00;
	out[1] = m01;
	out[2] = m02;
	out[3] = m03;
	out[4] = m10;
	out[5] = m11;
	out[6] = m12;
	out[7] = m13;
	out[8] = m20;
	out[9] = m21;
	out[10] = m22;
	out[11] = m23;
	out[12] = m30;
	out[13] = m31;
	out[14] = m32;
	out[15] = m33;
	return out;
};
mme_math_glmatrix_Mat4Tools.identity = function(out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = 1;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 0;
	out[5] = 1;
	out[6] = 0;
	out[7] = 0;
	out[8] = 0;
	out[9] = 0;
	out[10] = 1;
	out[11] = 0;
	out[12] = 0;
	out[13] = 0;
	out[14] = 0;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4Tools.transpose = function(a,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	if(out == a) {
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a12 = a[6];
		var a13 = a[7];
		var a23 = a[11];
		var v = a[4];
		out[1] = v;
		var v = a[8];
		out[2] = v;
		var v = a[12];
		out[3] = v;
		out[4] = a01;
		var v = a[9];
		out[6] = v;
		var v = a[13];
		out[7] = v;
		out[8] = a02;
		out[9] = a12;
		var v = a[14];
		out[11] = v;
		out[12] = a03;
		out[13] = a13;
		out[14] = a23;
	} else {
		var v = a[0];
		out[0] = v;
		var v = a[4];
		out[1] = v;
		var v = a[8];
		out[2] = v;
		var v = a[12];
		out[3] = v;
		var v = a[1];
		out[4] = v;
		var v = a[5];
		out[5] = v;
		var v = a[9];
		out[6] = v;
		var v = a[13];
		out[7] = v;
		var v = a[2];
		out[8] = v;
		var v = a[6];
		out[9] = v;
		var v = a[10];
		out[10] = v;
		var v = a[14];
		out[11] = v;
		var v = a[3];
		out[12] = v;
		var v = a[7];
		out[13] = v;
		var v = a[11];
		out[14] = v;
		var v = a[15];
		out[15] = v;
	}
	return out;
};
mme_math_glmatrix_Mat4Tools.invert = function(a,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a03 = a[3];
	var a10 = a[4];
	var a11 = a[5];
	var a12 = a[6];
	var a13 = a[7];
	var a20 = a[8];
	var a21 = a[9];
	var a22 = a[10];
	var a23 = a[11];
	var a30 = a[12];
	var a31 = a[13];
	var a32 = a[14];
	var a33 = a[15];
	var b00 = a00 * a11 - a01 * a10;
	var b01 = a00 * a12 - a02 * a10;
	var b02 = a00 * a13 - a03 * a10;
	var b03 = a01 * a12 - a02 * a11;
	var b04 = a01 * a13 - a03 * a11;
	var b05 = a02 * a13 - a03 * a12;
	var b06 = a20 * a31 - a21 * a30;
	var b07 = a20 * a32 - a22 * a30;
	var b08 = a20 * a33 - a23 * a30;
	var b09 = a21 * a32 - a22 * a31;
	var b10 = a21 * a33 - a23 * a31;
	var b11 = a22 * a33 - a23 * a32;
	var det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;
	if(det == 0.0) {
		return null;
	}
	det = 1.0 / det;
	var v = (a11 * b11 - a12 * b10 + a13 * b09) * det;
	out[0] = v;
	var v = (a02 * b10 - a01 * b11 - a03 * b09) * det;
	out[1] = v;
	var v = (a31 * b05 - a32 * b04 + a33 * b03) * det;
	out[2] = v;
	var v = (a22 * b04 - a21 * b05 - a23 * b03) * det;
	out[3] = v;
	var v = (a12 * b08 - a10 * b11 - a13 * b07) * det;
	out[4] = v;
	var v = (a00 * b11 - a02 * b08 + a03 * b07) * det;
	out[5] = v;
	var v = (a32 * b02 - a30 * b05 - a33 * b01) * det;
	out[6] = v;
	var v = (a20 * b05 - a22 * b02 + a23 * b01) * det;
	out[7] = v;
	var v = (a10 * b10 - a11 * b08 + a13 * b06) * det;
	out[8] = v;
	var v = (a01 * b08 - a00 * b10 - a03 * b06) * det;
	out[9] = v;
	var v = (a30 * b04 - a31 * b02 + a33 * b00) * det;
	out[10] = v;
	var v = (a21 * b02 - a20 * b04 - a23 * b00) * det;
	out[11] = v;
	var v = (a11 * b07 - a10 * b09 - a12 * b06) * det;
	out[12] = v;
	var v = (a00 * b09 - a01 * b07 + a02 * b06) * det;
	out[13] = v;
	var v = (a31 * b01 - a30 * b03 - a32 * b00) * det;
	out[14] = v;
	var v = (a20 * b03 - a21 * b01 + a22 * b00) * det;
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.adjoint = function(a,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a03 = a[3];
	var a10 = a[4];
	var a11 = a[5];
	var a12 = a[6];
	var a13 = a[7];
	var a20 = a[8];
	var a21 = a[9];
	var a22 = a[10];
	var a23 = a[11];
	var a30 = a[12];
	var a31 = a[13];
	var a32 = a[14];
	var a33 = a[15];
	var v = a11 * (a22 * a33 - a23 * a32) - a21 * (a12 * a33 - a13 * a32) + a31 * (a12 * a23 - a13 * a22);
	out[0] = v;
	var v = -(a01 * (a22 * a33 - a23 * a32) - a21 * (a02 * a33 - a03 * a32) + a31 * (a02 * a23 - a03 * a22));
	out[1] = v;
	var v = a01 * (a12 * a33 - a13 * a32) - a11 * (a02 * a33 - a03 * a32) + a31 * (a02 * a13 - a03 * a12);
	out[2] = v;
	var v = -(a01 * (a12 * a23 - a13 * a22) - a11 * (a02 * a23 - a03 * a22) + a21 * (a02 * a13 - a03 * a12));
	out[3] = v;
	var v = -(a10 * (a22 * a33 - a23 * a32) - a20 * (a12 * a33 - a13 * a32) + a30 * (a12 * a23 - a13 * a22));
	out[4] = v;
	var v = a00 * (a22 * a33 - a23 * a32) - a20 * (a02 * a33 - a03 * a32) + a30 * (a02 * a23 - a03 * a22);
	out[5] = v;
	var v = -(a00 * (a12 * a33 - a13 * a32) - a10 * (a02 * a33 - a03 * a32) + a30 * (a02 * a13 - a03 * a12));
	out[6] = v;
	var v = a00 * (a12 * a23 - a13 * a22) - a10 * (a02 * a23 - a03 * a22) + a20 * (a02 * a13 - a03 * a12);
	out[7] = v;
	var v = a10 * (a21 * a33 - a23 * a31) - a20 * (a11 * a33 - a13 * a31) + a30 * (a11 * a23 - a13 * a21);
	out[8] = v;
	var v = -(a00 * (a21 * a33 - a23 * a31) - a20 * (a01 * a33 - a03 * a31) + a30 * (a01 * a23 - a03 * a21));
	out[9] = v;
	var v = a00 * (a11 * a33 - a13 * a31) - a10 * (a01 * a33 - a03 * a31) + a30 * (a01 * a13 - a03 * a11);
	out[10] = v;
	var v = -(a00 * (a11 * a23 - a13 * a21) - a10 * (a01 * a23 - a03 * a21) + a20 * (a01 * a13 - a03 * a11));
	out[11] = v;
	var v = -(a10 * (a21 * a32 - a22 * a31) - a20 * (a11 * a32 - a12 * a31) + a30 * (a11 * a22 - a12 * a21));
	out[12] = v;
	var v = a00 * (a21 * a32 - a22 * a31) - a20 * (a01 * a32 - a02 * a31) + a30 * (a01 * a22 - a02 * a21);
	out[13] = v;
	var v = -(a00 * (a11 * a32 - a12 * a31) - a10 * (a01 * a32 - a02 * a31) + a30 * (a01 * a12 - a02 * a11));
	out[14] = v;
	var v = a00 * (a11 * a22 - a12 * a21) - a10 * (a01 * a22 - a02 * a21) + a20 * (a01 * a12 - a02 * a11);
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.determinant = function(a) {
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a03 = a[3];
	var a10 = a[4];
	var a11 = a[5];
	var a12 = a[6];
	var a13 = a[7];
	var a20 = a[8];
	var a21 = a[9];
	var a22 = a[10];
	var a23 = a[11];
	var a30 = a[12];
	var a31 = a[13];
	var a32 = a[14];
	var a33 = a[15];
	var b00 = a00 * a11 - a01 * a10;
	var b01 = a00 * a12 - a02 * a10;
	var b02 = a00 * a13 - a03 * a10;
	var b03 = a01 * a12 - a02 * a11;
	var b04 = a01 * a13 - a03 * a11;
	var b05 = a02 * a13 - a03 * a12;
	var b06 = a20 * a31 - a21 * a30;
	var b07 = a20 * a32 - a22 * a30;
	var b08 = a20 * a33 - a23 * a30;
	var b09 = a21 * a32 - a22 * a31;
	var b10 = a21 * a33 - a23 * a31;
	var b11 = a22 * a33 - a23 * a32;
	return b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;
};
mme_math_glmatrix_Mat4Tools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a03 = a[3];
	var a10 = a[4];
	var a11 = a[5];
	var a12 = a[6];
	var a13 = a[7];
	var a20 = a[8];
	var a21 = a[9];
	var a22 = a[10];
	var a23 = a[11];
	var a30 = a[12];
	var a31 = a[13];
	var a32 = a[14];
	var a33 = a[15];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	var v = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
	out[0] = v;
	var v = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
	out[1] = v;
	var v = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
	out[2] = v;
	var v = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
	out[3] = v;
	b0 = b[4];
	b1 = b[5];
	b2 = b[6];
	b3 = b[7];
	var v = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
	out[4] = v;
	var v = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
	out[5] = v;
	var v = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
	out[6] = v;
	var v = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
	out[7] = v;
	b0 = b[8];
	b1 = b[9];
	b2 = b[10];
	b3 = b[11];
	var v = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
	out[8] = v;
	var v = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
	out[9] = v;
	var v = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
	out[10] = v;
	var v = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
	out[11] = v;
	b0 = b[12];
	b1 = b[13];
	b2 = b[14];
	b3 = b[15];
	var v = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
	out[12] = v;
	var v = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
	out[13] = v;
	var v = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
	out[14] = v;
	var v = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.translate = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var z = v[2];
	var a00;
	var a01;
	var a02;
	var a03;
	var a10;
	var a11;
	var a12;
	var a13;
	var a20;
	var a21;
	var a22;
	var a23;
	if(a == out) {
		var v = a[0] * x + a[4] * y + a[8] * z + a[12];
		out[12] = v;
		var v = a[1] * x + a[5] * y + a[9] * z + a[13];
		out[13] = v;
		var v = a[2] * x + a[6] * y + a[10] * z + a[14];
		out[14] = v;
		var v = a[3] * x + a[7] * y + a[11] * z + a[15];
		out[15] = v;
	} else {
		a00 = a[0];
		a01 = a[1];
		a02 = a[2];
		a03 = a[3];
		a10 = a[4];
		a11 = a[5];
		a12 = a[6];
		a13 = a[7];
		a20 = a[8];
		a21 = a[9];
		a22 = a[10];
		a23 = a[11];
		out[0] = a00;
		out[1] = a01;
		out[2] = a02;
		out[3] = a03;
		out[4] = a10;
		out[5] = a11;
		out[6] = a12;
		out[7] = a13;
		out[8] = a20;
		out[9] = a21;
		out[10] = a22;
		out[11] = a23;
		var v = a00 * x + a10 * y + a20 * z + a[12];
		out[12] = v;
		var v = a01 * x + a11 * y + a21 * z + a[13];
		out[13] = v;
		var v = a02 * x + a12 * y + a22 * z + a[14];
		out[14] = v;
		var v = a03 * x + a13 * y + a23 * z + a[15];
		out[15] = v;
	}
	return out;
};
mme_math_glmatrix_Mat4Tools.scale = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var z = v[2];
	var v = a[0] * x;
	out[0] = v;
	var v = a[1] * x;
	out[1] = v;
	var v = a[2] * x;
	out[2] = v;
	var v = a[3] * x;
	out[3] = v;
	var v = a[4] * y;
	out[4] = v;
	var v = a[5] * y;
	out[5] = v;
	var v = a[6] * y;
	out[6] = v;
	var v = a[7] * y;
	out[7] = v;
	var v = a[8] * z;
	out[8] = v;
	var v = a[9] * z;
	out[9] = v;
	var v = a[10] * z;
	out[10] = v;
	var v = a[11] * z;
	out[11] = v;
	var v = a[12];
	out[12] = v;
	var v = a[13];
	out[13] = v;
	var v = a[14];
	out[14] = v;
	var v = a[15];
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.rotate = function(a,rad,axis,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = axis[0];
	var y = axis[1];
	var z = axis[2];
	var len = Math.sqrt(x * x + y * y + z * z);
	if(len < 0.000001) {
		return null;
	}
	len = 1 / len;
	x *= len;
	y *= len;
	z *= len;
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	var t = 1 - c;
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a03 = a[3];
	var a10 = a[4];
	var a11 = a[5];
	var a12 = a[6];
	var a13 = a[7];
	var a20 = a[8];
	var a21 = a[9];
	var a22 = a[10];
	var a23 = a[11];
	var b00 = x * x * t + c;
	var b01 = y * x * t + z * s;
	var b02 = z * x * t - y * s;
	var b10 = x * y * t - z * s;
	var b11 = y * y * t + c;
	var b12 = z * y * t + x * s;
	var b20 = x * z * t + y * s;
	var b21 = y * z * t - x * s;
	var b22 = z * z * t + c;
	var v = a00 * b00 + a10 * b01 + a20 * b02;
	out[0] = v;
	var v = a01 * b00 + a11 * b01 + a21 * b02;
	out[1] = v;
	var v = a02 * b00 + a12 * b01 + a22 * b02;
	out[2] = v;
	var v = a03 * b00 + a13 * b01 + a23 * b02;
	out[3] = v;
	var v = a00 * b10 + a10 * b11 + a20 * b12;
	out[4] = v;
	var v = a01 * b10 + a11 * b11 + a21 * b12;
	out[5] = v;
	var v = a02 * b10 + a12 * b11 + a22 * b12;
	out[6] = v;
	var v = a03 * b10 + a13 * b11 + a23 * b12;
	out[7] = v;
	var v = a00 * b20 + a10 * b21 + a20 * b22;
	out[8] = v;
	var v = a01 * b20 + a11 * b21 + a21 * b22;
	out[9] = v;
	var v = a02 * b20 + a12 * b21 + a22 * b22;
	out[10] = v;
	var v = a03 * b20 + a13 * b21 + a23 * b22;
	out[11] = v;
	if(a != out) {
		var v = a[12];
		out[12] = v;
		var v = a[13];
		out[13] = v;
		var v = a[14];
		out[14] = v;
		var v = a[15];
		out[15] = v;
	}
	return out;
};
mme_math_glmatrix_Mat4Tools.rotateX = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	var a10 = a[4];
	var a11 = a[5];
	var a12 = a[6];
	var a13 = a[7];
	var a20 = a[8];
	var a21 = a[9];
	var a22 = a[10];
	var a23 = a[11];
	if(a != out) {
		var v = a[0];
		out[0] = v;
		var v = a[1];
		out[1] = v;
		var v = a[2];
		out[2] = v;
		var v = a[3];
		out[3] = v;
		var v = a[12];
		out[12] = v;
		var v = a[13];
		out[13] = v;
		var v = a[14];
		out[14] = v;
		var v = a[15];
		out[15] = v;
	}
	var v = a10 * c + a20 * s;
	out[4] = v;
	var v = a11 * c + a21 * s;
	out[5] = v;
	var v = a12 * c + a22 * s;
	out[6] = v;
	var v = a13 * c + a23 * s;
	out[7] = v;
	var v = a20 * c - a10 * s;
	out[8] = v;
	var v = a21 * c - a11 * s;
	out[9] = v;
	var v = a22 * c - a12 * s;
	out[10] = v;
	var v = a23 * c - a13 * s;
	out[11] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.rotateY = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a03 = a[3];
	var a20 = a[8];
	var a21 = a[9];
	var a22 = a[10];
	var a23 = a[11];
	if(a != out) {
		var v = a[4];
		out[4] = v;
		var v = a[5];
		out[5] = v;
		var v = a[6];
		out[6] = v;
		var v = a[7];
		out[7] = v;
		var v = a[12];
		out[12] = v;
		var v = a[13];
		out[13] = v;
		var v = a[14];
		out[14] = v;
		var v = a[15];
		out[15] = v;
	}
	var v = a00 * c - a20 * s;
	out[0] = v;
	var v = a01 * c - a21 * s;
	out[1] = v;
	var v = a02 * c - a22 * s;
	out[2] = v;
	var v = a03 * c - a23 * s;
	out[3] = v;
	var v = a00 * s + a20 * c;
	out[8] = v;
	var v = a01 * s + a21 * c;
	out[9] = v;
	var v = a02 * s + a22 * c;
	out[10] = v;
	var v = a03 * s + a23 * c;
	out[11] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.rotateZ = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var s = Math.sin(rad);
	var c = Math.cos(rad);
	var a00 = a[0];
	var a01 = a[1];
	var a02 = a[2];
	var a03 = a[3];
	var a10 = a[4];
	var a11 = a[5];
	var a12 = a[6];
	var a13 = a[7];
	if(a != out) {
		var v = a[8];
		out[8] = v;
		var v = a[9];
		out[9] = v;
		var v = a[10];
		out[10] = v;
		var v = a[11];
		out[11] = v;
		var v = a[12];
		out[12] = v;
		var v = a[13];
		out[13] = v;
		var v = a[14];
		out[14] = v;
		var v = a[15];
		out[15] = v;
	}
	var v = a00 * c + a10 * s;
	out[0] = v;
	var v = a01 * c + a11 * s;
	out[1] = v;
	var v = a02 * c + a12 * s;
	out[2] = v;
	var v = a03 * c + a13 * s;
	out[3] = v;
	var v = a10 * c - a00 * s;
	out[4] = v;
	var v = a11 * c - a01 * s;
	out[5] = v;
	var v = a12 * c - a02 * s;
	out[6] = v;
	var v = a13 * c - a03 * s;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.getTranslation = function(mat,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = mat[12];
	out[0] = v;
	var v = mat[13];
	out[1] = v;
	var v = mat[14];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.getScaling = function(mat,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var m11 = mat[0];
	var m12 = mat[1];
	var m13 = mat[2];
	var m21 = mat[4];
	var m22 = mat[5];
	var m23 = mat[6];
	var m31 = mat[8];
	var m32 = mat[9];
	var m33 = mat[10];
	var v = Math.sqrt(m11 * m11 + m12 * m12 + m13 * m13);
	out[0] = v;
	var v = Math.sqrt(m21 * m21 + m22 * m22 + m23 * m23);
	out[1] = v;
	var v = Math.sqrt(m31 * m31 + m32 * m32 + m33 * m33);
	out[2] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.getRotation = function(mat,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var this1 = new Array(3);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	var scaling = this2;
	mme_math_glmatrix_Mat4Tools.getScaling(mat,scaling);
	var is1 = 1 / scaling[0];
	var is2 = 1 / scaling[1];
	var is3 = 1 / scaling[2];
	var sm11 = mat[0] * is1;
	var sm12 = mat[1] * is2;
	var sm13 = mat[2] * is3;
	var sm21 = mat[4] * is1;
	var sm22 = mat[5] * is2;
	var sm23 = mat[6] * is3;
	var sm31 = mat[8] * is1;
	var sm32 = mat[9] * is2;
	var sm33 = mat[10] * is3;
	var trace = sm11 + sm22 + sm33;
	var S = 0.0;
	if(trace > 0) {
		S = Math.sqrt(trace + 1.0) * 2;
		var v = 0.25 * S;
		out[3] = v;
		var v = (sm23 - sm32) / S;
		out[0] = v;
		var v = (sm31 - sm13) / S;
		out[1] = v;
		var v = (sm12 - sm21) / S;
		out[2] = v;
	} else if(sm11 > sm22 && sm11 > sm33) {
		S = Math.sqrt(1.0 + sm11 - sm22 - sm33) * 2;
		var v = (sm23 - sm32) / S;
		out[3] = v;
		var v = 0.25 * S;
		out[0] = v;
		var v = (sm12 + sm21) / S;
		out[1] = v;
		var v = (sm31 + sm13) / S;
		out[2] = v;
	} else if(sm22 > sm33) {
		S = Math.sqrt(1.0 + sm22 - sm11 - sm33) * 2;
		var v = (sm31 - sm13) / S;
		out[3] = v;
		var v = (sm12 + sm21) / S;
		out[0] = v;
		var v = 0.25 * S;
		out[1] = v;
		var v = (sm23 + sm32) / S;
		out[2] = v;
	} else {
		S = Math.sqrt(1.0 + sm33 - sm11 - sm22) * 2;
		var v = (sm12 - sm21) / S;
		out[3] = v;
		var v = (sm31 + sm13) / S;
		out[0] = v;
		var v = (sm23 + sm32) / S;
		out[1] = v;
		var v = 0.25 * S;
		out[2] = v;
	}
	return out;
};
mme_math_glmatrix_Mat4Tools.frustum = function(left,right,bottom,top,near,far,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var rl = 1 / (right - left);
	var tb = 1 / (top - bottom);
	var nf = 1 / (near - far);
	var v = near * 2 * rl;
	out[0] = v;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 0;
	var v = near * 2 * tb;
	out[5] = v;
	out[6] = 0;
	out[7] = 0;
	var v = (right + left) * rl;
	out[8] = v;
	var v = (top + bottom) * tb;
	out[9] = v;
	var v = (far + near) * nf;
	out[10] = v;
	out[11] = -1;
	out[12] = 0;
	out[13] = 0;
	var v = far * near * 2 * nf;
	out[14] = v;
	out[15] = 0;
	return out;
};
mme_math_glmatrix_Mat4Tools.perspective = function(fovy,aspect,near,far,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var f = 1.0 / Math.tan(fovy / 2);
	var nf;
	var v = f / aspect;
	out[0] = v;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 0;
	out[5] = f;
	out[6] = 0;
	out[7] = 0;
	out[8] = 0;
	out[9] = 0;
	out[11] = -1;
	out[12] = 0;
	out[13] = 0;
	out[15] = 0;
	if(far != null && far != -Infinity && far != Infinity) {
		nf = 1 / (near - far);
		var v = (far + near) * nf;
		out[10] = v;
		var v = 2 * far * near * nf;
		out[14] = v;
	} else {
		out[10] = -1;
		var v = -2 * near;
		out[14] = v;
	}
	return out;
};
mme_math_glmatrix_Mat4Tools.perspectiveFromFieldOfView = function(fov,near,far,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var upTan = Math.tan(fov.upDegrees * Math.PI / 180.0);
	var downTan = Math.tan(fov.downDegrees * Math.PI / 180.0);
	var leftTan = Math.tan(fov.leftDegrees * Math.PI / 180.0);
	var rightTan = Math.tan(fov.rightDegrees * Math.PI / 180.0);
	var xScale = 2.0 / (leftTan + rightTan);
	var yScale = 2.0 / (upTan + downTan);
	out[0] = xScale;
	out[1] = 0.0;
	out[2] = 0.0;
	out[3] = 0.0;
	out[4] = 0.0;
	out[5] = yScale;
	out[6] = 0.0;
	out[7] = 0.0;
	var v = -((leftTan - rightTan) * xScale * 0.5);
	out[8] = v;
	var v = (upTan - downTan) * yScale * 0.5;
	out[9] = v;
	var v = far / (near - far);
	out[10] = v;
	out[11] = -1.0;
	out[12] = 0.0;
	out[13] = 0.0;
	var v = far * near / (near - far);
	out[14] = v;
	out[15] = 0.0;
	return out;
};
mme_math_glmatrix_Mat4Tools.ortho = function(left,right,bottom,top,near,far,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var lr = 1 / (left - right);
	var bt = 1 / (bottom - top);
	var nf = 1 / (near - far);
	var v = -2 * lr;
	out[0] = v;
	out[1] = 0;
	out[2] = 0;
	out[3] = 0;
	out[4] = 0;
	var v = -2 * bt;
	out[5] = v;
	out[6] = 0;
	out[7] = 0;
	out[8] = 0;
	out[9] = 0;
	var v = 2 * nf;
	out[10] = v;
	out[11] = 0;
	var v = (left + right) * lr;
	out[12] = v;
	var v = (top + bottom) * bt;
	out[13] = v;
	var v = (far + near) * nf;
	out[14] = v;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4Tools.lookAt = function(eye,center,up,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var eyex = eye[0];
	var eyey = eye[1];
	var eyez = eye[2];
	var upx = up[0];
	var upy = up[1];
	var upz = up[2];
	var centerx = center[0];
	var centery = center[1];
	var centerz = center[2];
	if(Math.abs(eyex - centerx) < 0.000001 && Math.abs(eyey - centery) < 0.000001 && Math.abs(eyez - centerz) < 0.000001) {
		return mme_math_glmatrix_Mat4Tools.identity(out);
	}
	var z0 = eyex - centerx;
	var z1 = eyey - centery;
	var z2 = eyez - centerz;
	var len = 1 / Math.sqrt(z0 * z0 + z1 * z1 + z2 * z2);
	z0 *= len;
	z1 *= len;
	z2 *= len;
	var x0 = upy * z2 - upz * z1;
	var x1 = upz * z0 - upx * z2;
	var x2 = upx * z1 - upy * z0;
	len = Math.sqrt(x0 * x0 + x1 * x1 + x2 * x2);
	if(len == 0.0) {
		x0 = 0;
		x1 = 0;
		x2 = 0;
	} else {
		len = 1 / len;
		x0 *= len;
		x1 *= len;
		x2 *= len;
	}
	var y0 = z1 * x2 - z2 * x1;
	var y1 = z2 * x0 - z0 * x2;
	var y2 = z0 * x1 - z1 * x0;
	len = Math.sqrt(y0 * y0 + y1 * y1 + y2 * y2);
	if(len == 0.0) {
		y0 = 0;
		y1 = 0;
		y2 = 0;
	} else {
		len = 1 / len;
		y0 *= len;
		y1 *= len;
		y2 *= len;
	}
	out[0] = x0;
	out[1] = y0;
	out[2] = z0;
	out[3] = 0;
	out[4] = x1;
	out[5] = y1;
	out[6] = z1;
	out[7] = 0;
	out[8] = x2;
	out[9] = y2;
	out[10] = z2;
	out[11] = 0;
	var v = -(x0 * eyex + x1 * eyey + x2 * eyez);
	out[12] = v;
	var v = -(y0 * eyex + y1 * eyey + y2 * eyez);
	out[13] = v;
	var v = -(z0 * eyex + z1 * eyey + z2 * eyez);
	out[14] = v;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4Tools.targetTo = function(eye,target,up,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var eyex = eye[0];
	var eyey = eye[1];
	var eyez = eye[2];
	var upx = up[0];
	var upy = up[1];
	var upz = up[2];
	var z0 = eyex - target[0];
	var z1 = eyey - target[1];
	var z2 = eyez - target[2];
	var len = z0 * z0 + z1 * z1 + z2 * z2;
	if(len > 0) {
		len = 1 / Math.sqrt(len);
		z0 *= len;
		z1 *= len;
		z2 *= len;
	}
	var x0 = upy * z2 - upz * z1;
	var x1 = upz * z0 - upx * z2;
	var x2 = upx * z1 - upy * z0;
	len = x0 * x0 + x1 * x1 + x2 * x2;
	if(len > 0) {
		len = 1 / Math.sqrt(len);
		x0 *= len;
		x1 *= len;
		x2 *= len;
	}
	out[0] = x0;
	out[1] = x1;
	out[2] = x2;
	out[3] = 0;
	var v = z1 * x2 - z2 * x1;
	out[4] = v;
	var v = z2 * x0 - z0 * x2;
	out[5] = v;
	var v = z0 * x1 - z1 * x0;
	out[6] = v;
	out[7] = 0;
	out[8] = z0;
	out[9] = z1;
	out[10] = z2;
	out[11] = 0;
	out[12] = eyex;
	out[13] = eyey;
	out[14] = eyez;
	out[15] = 1;
	return out;
};
mme_math_glmatrix_Mat4Tools.str = function(a) {
	return "Mat4(" + a[0] + ", " + a[1] + ", " + a[2] + ", " + a[3] + ", " + a[4] + ", " + a[5] + ", " + a[6] + ", " + a[7] + ", " + a[8] + ", " + a[9] + ", " + a[10] + ", " + a[11] + ", " + a[12] + ", " + a[13] + ", " + a[14] + ", " + a[15] + ")";
};
mme_math_glmatrix_Mat4Tools.frob = function(a) {
	return Math.sqrt(Math.pow(a[0],2) + Math.pow(a[1],2) + Math.pow(a[2],2) + Math.pow(a[3],2) + Math.pow(a[4],2) + Math.pow(a[5],2) + Math.pow(a[6],2) + Math.pow(a[7],2) + Math.pow(a[8],2) + Math.pow(a[9],2) + Math.pow(a[10],2) + Math.pow(a[11],2) + Math.pow(a[12],2) + Math.pow(a[13],2) + Math.pow(a[14],2) + Math.pow(a[15],2));
};
mme_math_glmatrix_Mat4Tools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	var v = a[2] + b[2];
	out[2] = v;
	var v = a[3] + b[3];
	out[3] = v;
	var v = a[4] + b[4];
	out[4] = v;
	var v = a[5] + b[5];
	out[5] = v;
	var v = a[6] + b[6];
	out[6] = v;
	var v = a[7] + b[7];
	out[7] = v;
	var v = a[8] + b[8];
	out[8] = v;
	var v = a[9] + b[9];
	out[9] = v;
	var v = a[10] + b[10];
	out[10] = v;
	var v = a[11] + b[11];
	out[11] = v;
	var v = a[12] + b[12];
	out[12] = v;
	var v = a[13] + b[13];
	out[13] = v;
	var v = a[14] + b[14];
	out[14] = v;
	var v = a[15] + b[15];
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.subtract = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] - b[0];
	out[0] = v;
	var v = a[1] - b[1];
	out[1] = v;
	var v = a[2] - b[2];
	out[2] = v;
	var v = a[3] - b[3];
	out[3] = v;
	var v = a[4] - b[4];
	out[4] = v;
	var v = a[5] - b[5];
	out[5] = v;
	var v = a[6] - b[6];
	out[6] = v;
	var v = a[7] - b[7];
	out[7] = v;
	var v = a[8] - b[8];
	out[8] = v;
	var v = a[9] - b[9];
	out[9] = v;
	var v = a[10] - b[10];
	out[10] = v;
	var v = a[11] - b[11];
	out[11] = v;
	var v = a[12] - b[12];
	out[12] = v;
	var v = a[13] - b[13];
	out[13] = v;
	var v = a[14] - b[14];
	out[14] = v;
	var v = a[15] - b[15];
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.multiplyVec2 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var v = a[0] * x + a[4] * y + a[12];
	out[0] = v;
	var v = a[1] * x + a[5] * y + a[13];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.multiplyVec3 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var z = v[2];
	var w = a[3] * x + a[7] * y + a[11] * z + a[15];
	if(w == 0.0) {
		w = 1.0;
	}
	var v = (a[0] * x + a[4] * y + a[8] * z + a[12]) / w;
	out[0] = v;
	var v = (a[1] * x + a[5] * y + a[9] * z + a[13]) / w;
	out[1] = v;
	var v = (a[2] * x + a[6] * y + a[10] * z + a[14]) / w;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.multiplyVec4 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var z = v[2];
	var w = v[3];
	var v = a[0] * x + a[4] * y + a[8] * z + a[12] * w;
	out[0] = v;
	var v = a[1] * x + a[5] * y + a[9] * z + a[13] * w;
	out[1] = v;
	var v = a[2] * x + a[6] * y + a[10] * z + a[14] * w;
	out[2] = v;
	var v = a[3] * x + a[7] * y + a[11] * z + a[15] * w;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.multiplyScalar = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	var v = a[2] * b;
	out[2] = v;
	var v = a[3] * b;
	out[3] = v;
	var v = a[4] * b;
	out[4] = v;
	var v = a[5] * b;
	out[5] = v;
	var v = a[6] * b;
	out[6] = v;
	var v = a[7] * b;
	out[7] = v;
	var v = a[8] * b;
	out[8] = v;
	var v = a[9] * b;
	out[9] = v;
	var v = a[10] * b;
	out[10] = v;
	var v = a[11] * b;
	out[11] = v;
	var v = a[12] * b;
	out[12] = v;
	var v = a[13] * b;
	out[13] = v;
	var v = a[14] * b;
	out[14] = v;
	var v = a[15] * b;
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.multiplyScalarAndAdd = function(a,b,scale,out) {
	if(out == null) {
		var this1 = new Array(16);
		var this2 = this1;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		this2[4] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[8] = 0.0;
		this2[9] = 0.0;
		this2[11] = 0.0;
		this2[12] = 0.0;
		this2[13] = 0.0;
		this2[14] = 0.0;
		this2[0] = 1.0;
		this2[5] = 1.0;
		this2[10] = 1.0;
		this2[15] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0] * scale;
	out[0] = v;
	var v = a[1] + b[1] * scale;
	out[1] = v;
	var v = a[2] + b[2] * scale;
	out[2] = v;
	var v = a[3] + b[3] * scale;
	out[3] = v;
	var v = a[4] + b[4] * scale;
	out[4] = v;
	var v = a[5] + b[5] * scale;
	out[5] = v;
	var v = a[6] + b[6] * scale;
	out[6] = v;
	var v = a[7] + b[7] * scale;
	out[7] = v;
	var v = a[8] + b[8] * scale;
	out[8] = v;
	var v = a[9] + b[9] * scale;
	out[9] = v;
	var v = a[10] + b[10] * scale;
	out[10] = v;
	var v = a[11] + b[11] * scale;
	out[11] = v;
	var v = a[12] + b[12] * scale;
	out[12] = v;
	var v = a[13] + b[13] * scale;
	out[13] = v;
	var v = a[14] + b[14] * scale;
	out[14] = v;
	var v = a[15] + b[15] * scale;
	out[15] = v;
	return out;
};
mme_math_glmatrix_Mat4Tools.exactEquals = function(a,b) {
	if(a[0] == b[0] && a[1] == b[1] && a[2] == b[2] && a[3] == b[3] && a[4] == b[4] && a[5] == b[5] && a[6] == b[6] && a[7] == b[7] && a[8] == b[8] && a[9] == b[9] && a[10] == b[10] && a[11] == b[11] && a[12] == b[12] && a[13] == b[13] && a[14] == b[14]) {
		return a[15] == b[15];
	} else {
		return false;
	}
};
mme_math_glmatrix_Mat4Tools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var a4 = a[4];
	var a5 = a[5];
	var a6 = a[6];
	var a7 = a[7];
	var a8 = a[8];
	var a9 = a[9];
	var a10 = a[10];
	var a11 = a[11];
	var a12 = a[12];
	var a13 = a[13];
	var a14 = a[14];
	var a15 = a[15];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	var b4 = b[4];
	var b5 = b[5];
	var b6 = b[6];
	var b7 = b[7];
	var b8 = b[8];
	var b9 = b[9];
	var b10 = b[10];
	var b11 = b[11];
	var b12 = b[12];
	var b13 = b[13];
	var b14 = b[14];
	var b15 = b[15];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0))) && Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1))) && Math.abs(a2 - b2) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a2),Math.abs(b2))) && Math.abs(a3 - b3) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a3),Math.abs(b3))) && Math.abs(a4 - b4) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a4),Math.abs(b4))) && Math.abs(a5 - b5) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a5),Math.abs(b5))) && Math.abs(a6 - b6) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a6),Math.abs(b6))) && Math.abs(a7 - b7) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a7),Math.abs(b7))) && Math.abs(a8 - b8) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a8),Math.abs(b8))) && Math.abs(a9 - b9) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a9),Math.abs(b9))) && Math.abs(a10 - b10) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a10),Math.abs(b10))) && Math.abs(a11 - b11) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a11),Math.abs(b11))) && Math.abs(a12 - b12) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a12),Math.abs(b12))) && Math.abs(a13 - b13) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a13),Math.abs(b13))) && Math.abs(a14 - b14) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a14),Math.abs(b14)))) {
		return Math.abs(a15 - b15) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a15),Math.abs(b15)));
	} else {
		return false;
	}
};
var mme_math_glmatrix_Quat = {};
mme_math_glmatrix_Quat._new = function() {
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 1.0;
	return this2;
};
mme_math_glmatrix_Quat.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Quat.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Quat.get_x = function(this1) {
	return this1[0];
};
mme_math_glmatrix_Quat.set_x = function(this1,x) {
	return this1[0] = x;
};
mme_math_glmatrix_Quat.get_y = function(this1) {
	return this1[1];
};
mme_math_glmatrix_Quat.set_y = function(this1,y) {
	return this1[1] = y;
};
mme_math_glmatrix_Quat.get_z = function(this1) {
	return this1[2];
};
mme_math_glmatrix_Quat.set_z = function(this1,z) {
	return this1[2] = z;
};
mme_math_glmatrix_Quat.get_w = function(this1) {
	return this1[3];
};
mme_math_glmatrix_Quat.set_w = function(this1,w) {
	return this1[3] = w;
};
mme_math_glmatrix_Quat.fromArray = function(a) {
	return mme_math_glmatrix_Quat.fromValues(null,a[0],a[1],a[2],a[3]);
};
mme_math_glmatrix_Quat.toArray = function(this1) {
	return [this1[0],this1[1],this1[2],this1[3],this1[4]];
};
mme_math_glmatrix_Quat.toString = function(this1) {
	return mme_math_glmatrix_QuatTools.str(this1);
};
mme_math_glmatrix_Quat.fromValues = function(out,x,y,z,w) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = x;
	out[1] = y;
	out[2] = z;
	out[3] = w;
	return out;
};
mme_math_glmatrix_Quat.fromAxisAngle = function(out,axis,rad) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	rad *= 0.5;
	var s = Math.sin(rad);
	var v = s * axis[0];
	out[0] = v;
	var v = s * axis[1];
	out[1] = v;
	var v = s * axis[2];
	out[2] = v;
	var v = Math.cos(rad);
	out[3] = v;
	return out;
};
mme_math_glmatrix_Quat.fromAxes = function(out,view,right,up) {
	var this1 = new Array(9);
	var this2 = this1;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	this2[5] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[0] = 1.0;
	this2[4] = 1.0;
	this2[8] = 1.0;
	var out1 = this2;
	var matr = out1;
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = right[0];
	matr[0] = v;
	var v = right[1];
	matr[3] = v;
	var v = right[2];
	matr[6] = v;
	var v = up[0];
	matr[1] = v;
	var v = up[1];
	matr[4] = v;
	var v = up[2];
	matr[7] = v;
	var v = -view[0];
	matr[2] = v;
	var v = -view[1];
	matr[5] = v;
	var v = -view[2];
	matr[8] = v;
	return mme_math_glmatrix_QuatTools.normalize(out,mme_math_glmatrix_Quat.fromMat3(out,matr));
};
mme_math_glmatrix_Quat.fromMat3 = function(out,m) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var fTrace = m[0] + m[4] + m[8];
	var fRoot;
	if(fTrace > 0.0) {
		fRoot = Math.sqrt(fTrace + 1.0);
		var v = 0.5 * fRoot;
		out[3] = v;
		fRoot = 0.5 / fRoot;
		var v = (m[5] - m[7]) * fRoot;
		out[0] = v;
		var v = (m[6] - m[2]) * fRoot;
		out[1] = v;
		var v = (m[1] - m[3]) * fRoot;
		out[2] = v;
	} else {
		var i = 0;
		if(m[4] > m[0]) {
			i = 1;
		}
		if(m[8] > m[i * 3 + i]) {
			i = 2;
		}
		var j = (i + 1) % 3;
		var k = (i + 2) % 3;
		fRoot = Math.sqrt(m[i * 3 + i] - m[j * 3 + j] - m[k * 3 + k] + 1.0);
		var v = 0.5 * fRoot;
		out[i] = v;
		fRoot = 0.5 / fRoot;
		var v = (m[j * 3 + k] - m[k * 3 + j]) * fRoot;
		out[3] = v;
		var v = (m[j * 3 + i] + m[i * 3 + j]) * fRoot;
		out[j] = v;
		var v = (m[k * 3 + i] + m[i * 3 + k]) * fRoot;
		out[k] = v;
	}
	return out;
};
mme_math_glmatrix_Quat.fromEuler = function(out,x,y,z) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var halfToRad = 0.5 * Math.PI / 180.0;
	x *= halfToRad;
	y *= halfToRad;
	z *= halfToRad;
	var sx = Math.sin(x);
	var cx = Math.cos(x);
	var sy = Math.sin(y);
	var cy = Math.cos(y);
	var sz = Math.sin(z);
	var cz = Math.cos(z);
	var v = sx * cy * cz - cx * sy * sz;
	out[0] = v;
	var v = cx * sy * cz + sx * cy * sz;
	out[1] = v;
	var v = cx * cy * sz - sx * sy * cz;
	out[2] = v;
	var v = cx * cy * cz + sx * sy * sz;
	out[3] = v;
	return out;
};
var mme_math_glmatrix_Quat2 = {};
mme_math_glmatrix_Quat2._new = function() {
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[4] = 0.0;
	this2[5] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[3] = 1.0;
	return this2;
};
mme_math_glmatrix_Quat2.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Quat2.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Quat2.get_x = function(this1) {
	return this1[0];
};
mme_math_glmatrix_Quat2.set_x = function(this1,x) {
	return this1[0] = x;
};
mme_math_glmatrix_Quat2.get_y = function(this1) {
	return this1[1];
};
mme_math_glmatrix_Quat2.set_y = function(this1,y) {
	return this1[1] = y;
};
mme_math_glmatrix_Quat2.get_z = function(this1) {
	return this1[2];
};
mme_math_glmatrix_Quat2.set_z = function(this1,z) {
	return this1[2] = z;
};
mme_math_glmatrix_Quat2.get_w = function(this1) {
	return this1[3];
};
mme_math_glmatrix_Quat2.set_w = function(this1,w) {
	return this1[3] = w;
};
mme_math_glmatrix_Quat2.get_dx = function(this1) {
	return this1[4];
};
mme_math_glmatrix_Quat2.set_dx = function(this1,dx) {
	return this1[4] = dx;
};
mme_math_glmatrix_Quat2.get_dy = function(this1) {
	return this1[5];
};
mme_math_glmatrix_Quat2.set_dy = function(this1,dy) {
	return this1[5] = dy;
};
mme_math_glmatrix_Quat2.get_dz = function(this1) {
	return this1[6];
};
mme_math_glmatrix_Quat2.set_dz = function(this1,dz) {
	return this1[6] = dz;
};
mme_math_glmatrix_Quat2.get_dw = function(this1) {
	return this1[7];
};
mme_math_glmatrix_Quat2.set_dw = function(this1,dw) {
	return this1[7] = dw;
};
mme_math_glmatrix_Quat2.fromArray = function(a) {
	return mme_math_glmatrix_Quat2.fromValues(null,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7]);
};
mme_math_glmatrix_Quat2.toArray = function(this1) {
	return [this1[0],this1[1],this1[2],this1[3],this1[4],this1[5],this1[6],this1[7]];
};
mme_math_glmatrix_Quat2.toString = function(this1) {
	return mme_math_glmatrix_Quat2Tools.str(this1);
};
mme_math_glmatrix_Quat2.fromValues = function(out,x1,y1,z1,w1,x2,y2,z2,w2) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	out[0] = x1;
	out[1] = y1;
	out[2] = z1;
	out[3] = w1;
	out[4] = x2;
	out[5] = y2;
	out[6] = z2;
	out[7] = w2;
	return out;
};
mme_math_glmatrix_Quat2.fromRotationTranslationValues = function(out,x1,y1,z1,w1,x2,y2,z2) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	out[0] = x1;
	out[1] = y1;
	out[2] = z1;
	out[3] = w1;
	var ax = x2 * 0.5;
	var ay = y2 * 0.5;
	var az = z2 * 0.5;
	var v = ax * w1 + ay * z1 - az * y1;
	out[4] = v;
	var v = ay * w1 + az * x1 - ax * z1;
	out[5] = v;
	var v = az * w1 + ax * y1 - ay * x1;
	out[6] = v;
	var v = -ax * x1 - ay * y1 - az * z1;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2.fromRotationTranslation = function(out,q,t) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var ax = t[0] * 0.5;
	var ay = t[1] * 0.5;
	var az = t[2] * 0.5;
	var bx = q[0];
	var by = q[1];
	var bz = q[2];
	var bw = q[3];
	out[0] = bx;
	out[1] = by;
	out[2] = bz;
	out[3] = bw;
	var v = ax * bw + ay * bz - az * by;
	out[4] = v;
	var v = ay * bw + az * bx - ax * bz;
	out[5] = v;
	var v = az * bw + ax * by - ay * bx;
	out[6] = v;
	var v = -ax * bx - ay * by - az * bz;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2.fromTranslation = function(out,t) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	out[0] = 0;
	out[1] = 0;
	out[2] = 0;
	out[3] = 1;
	var v = t[0] * 0.5;
	out[4] = v;
	var v = t[1] * 0.5;
	out[5] = v;
	var v = t[2] * 0.5;
	out[6] = v;
	out[7] = 0;
	return out;
};
mme_math_glmatrix_Quat2.fromRotation = function(out,q) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var v = q[0];
	out[0] = v;
	var v = q[1];
	out[1] = v;
	var v = q[2];
	out[2] = v;
	var v = q[3];
	out[3] = v;
	out[4] = 0;
	out[5] = 0;
	out[6] = 0;
	out[7] = 0;
	return out;
};
mme_math_glmatrix_Quat2.fromMat4 = function(out,a) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 1.0;
	var out1 = this2;
	var outer = out1;
	mme_math_glmatrix_Mat4Tools.getRotation(a,outer);
	var this1 = new Array(3);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	var t = this2;
	mme_math_glmatrix_Mat4Tools.getTranslation(a,t);
	mme_math_glmatrix_Quat2.fromRotationTranslation(out,outer,t);
	return out;
};
var mme_math_glmatrix_Quat2Tools = function() { };
mme_math_glmatrix_Quat2Tools.__name__ = true;
mme_math_glmatrix_Quat2Tools.create = function() {
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[4] = 0.0;
	this2[5] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[3] = 1.0;
	var dq = this2;
	return dq;
};
mme_math_glmatrix_Quat2Tools.clone = function(a) {
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[4] = 0.0;
	this2[5] = 0.0;
	this2[6] = 0.0;
	this2[7] = 0.0;
	this2[3] = 1.0;
	var dq = this2;
	var v = a[0];
	dq[0] = v;
	var v = a[1];
	dq[1] = v;
	var v = a[2];
	dq[2] = v;
	var v = a[3];
	dq[3] = v;
	var v = a[4];
	dq[4] = v;
	var v = a[5];
	dq[5] = v;
	var v = a[6];
	dq[6] = v;
	var v = a[7];
	dq[7] = v;
	return dq;
};
mme_math_glmatrix_Quat2Tools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	var v = a[4];
	out[4] = v;
	var v = a[5];
	out[5] = v;
	var v = a[6];
	out[6] = v;
	var v = a[7];
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.identity = function(out) {
	out[0] = 0;
	out[1] = 0;
	out[2] = 0;
	out[3] = 1;
	out[4] = 0;
	out[5] = 0;
	out[6] = 0;
	out[7] = 0;
	return out;
};
mme_math_glmatrix_Quat2Tools.set = function(out,x1,y1,z1,w1,x2,y2,z2,w2) {
	out[0] = x1;
	out[1] = y1;
	out[2] = z1;
	out[3] = w1;
	out[4] = x2;
	out[5] = y2;
	out[6] = z2;
	out[7] = w2;
	return out;
};
mme_math_glmatrix_Quat2Tools.getReal = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.getDual = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[4];
	out[0] = v;
	var v = a[5];
	out[1] = v;
	var v = a[6];
	out[2] = v;
	var v = a[7];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.setReal = function(out,a) {
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.setDual = function(out,q) {
	var v = q[0];
	out[4] = v;
	var v = q[1];
	out[5] = v;
	var v = q[2];
	out[6] = v;
	var v = q[3];
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.getTranslation = function(a,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var ax = a[4];
	var ay = a[5];
	var az = a[6];
	var aw = a[7];
	var bx = -a[0];
	var by = -a[1];
	var bz = -a[2];
	var bw = a[3];
	var v = (ax * bw + aw * bx + ay * bz - az * by) * 2;
	out[0] = v;
	var v = (ay * bw + aw * by + az * bx - ax * bz) * 2;
	out[1] = v;
	var v = (az * bw + aw * bz + ax * by - ay * bx) * 2;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.translate = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var ax1 = a[0];
	var ay1 = a[1];
	var az1 = a[2];
	var aw1 = a[3];
	var bx1 = v[0] * 0.5;
	var by1 = v[1] * 0.5;
	var bz1 = v[2] * 0.5;
	var ax2 = a[4];
	var ay2 = a[5];
	var az2 = a[6];
	var aw2 = a[7];
	out[0] = ax1;
	out[1] = ay1;
	out[2] = az1;
	out[3] = aw1;
	var v = aw1 * bx1 + ay1 * bz1 - az1 * by1 + ax2;
	out[4] = v;
	var v = aw1 * by1 + az1 * bx1 - ax1 * bz1 + ay2;
	out[5] = v;
	var v = aw1 * bz1 + ax1 * by1 - ay1 * bx1 + az2;
	out[6] = v;
	var v = -ax1 * bx1 - ay1 * by1 - az1 * bz1 + aw2;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateXReal = function(a,rad,out) {
	rad *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var bx = Math.sin(rad);
	var bw = Math.cos(rad);
	var v = ax * bw + aw * bx;
	out[0] = v;
	var v = ay * bw + az * bx;
	out[1] = v;
	var v = az * bw - ay * bx;
	out[2] = v;
	var v = aw * bw - ax * bx;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateX = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var bx = -a[0];
	var by = -a[1];
	var bz = -a[2];
	var bw = a[3];
	var ax = a[4];
	var ay = a[5];
	var az = a[6];
	var aw = a[7];
	var ax1 = ax * bw + aw * bx + ay * bz - az * by;
	var ay1 = ay * bw + aw * by + az * bx - ax * bz;
	var az1 = az * bw + aw * bz + ax * by - ay * bx;
	var aw1 = aw * bw - ax * bx - ay * by - az * bz;
	var rad1 = rad;
	rad1 *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var bx1 = Math.sin(rad1);
	var bw1 = Math.cos(rad1);
	var v = ax * bw1 + aw * bx1;
	out[0] = v;
	var v = ay * bw1 + az * bx1;
	out[1] = v;
	var v = az * bw1 - ay * bx1;
	out[2] = v;
	var v = aw * bw1 - ax * bx1;
	out[3] = v;
	bx = out[0];
	by = out[1];
	bz = out[2];
	bw = out[3];
	var v = ax1 * bw + aw1 * bx + ay1 * bz - az1 * by;
	out[4] = v;
	var v = ay1 * bw + aw1 * by + az1 * bx - ax1 * bz;
	out[5] = v;
	var v = az1 * bw + aw1 * bz + ax1 * by - ay1 * bx;
	out[6] = v;
	var v = aw1 * bw - ax1 * bx - ay1 * by - az1 * bz;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateYReal = function(a,rad,out) {
	rad *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var by = Math.sin(rad);
	var bw = Math.cos(rad);
	var v = ax * bw - az * by;
	out[0] = v;
	var v = ay * bw + aw * by;
	out[1] = v;
	var v = az * bw + ax * by;
	out[2] = v;
	var v = aw * bw - ay * by;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateY = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var bx = -a[0];
	var by = -a[1];
	var bz = -a[2];
	var bw = a[3];
	var ax = a[4];
	var ay = a[5];
	var az = a[6];
	var aw = a[7];
	var ax1 = ax * bw + aw * bx + ay * bz - az * by;
	var ay1 = ay * bw + aw * by + az * bx - ax * bz;
	var az1 = az * bw + aw * bz + ax * by - ay * bx;
	var aw1 = aw * bw - ax * bx - ay * by - az * bz;
	var rad1 = rad;
	rad1 *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var by1 = Math.sin(rad1);
	var bw1 = Math.cos(rad1);
	var v = ax * bw1 - az * by1;
	out[0] = v;
	var v = ay * bw1 + aw * by1;
	out[1] = v;
	var v = az * bw1 + ax * by1;
	out[2] = v;
	var v = aw * bw1 - ay * by1;
	out[3] = v;
	bx = out[0];
	by = out[1];
	bz = out[2];
	bw = out[3];
	var v = ax1 * bw + aw1 * bx + ay1 * bz - az1 * by;
	out[4] = v;
	var v = ay1 * bw + aw1 * by + az1 * bx - ax1 * bz;
	out[5] = v;
	var v = az1 * bw + aw1 * bz + ax1 * by - ay1 * bx;
	out[6] = v;
	var v = aw1 * bw - ax1 * bx - ay1 * by - az1 * bz;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateZReal = function(a,rad,out) {
	rad *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var bz = Math.sin(rad);
	var bw = Math.cos(rad);
	var v = ax * bw + ay * bz;
	out[0] = v;
	var v = ay * bw - ax * bz;
	out[1] = v;
	var v = az * bw + aw * bz;
	out[2] = v;
	var v = aw * bw - az * bz;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateZ = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var bx = -a[0];
	var by = -a[1];
	var bz = -a[2];
	var bw = a[3];
	var ax = a[4];
	var ay = a[5];
	var az = a[6];
	var aw = a[7];
	var ax1 = ax * bw + aw * bx + ay * bz - az * by;
	var ay1 = ay * bw + aw * by + az * bx - ax * bz;
	var az1 = az * bw + aw * bz + ax * by - ay * bx;
	var aw1 = aw * bw - ax * bx - ay * by - az * bz;
	var rad1 = rad;
	rad1 *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var bz1 = Math.sin(rad1);
	var bw1 = Math.cos(rad1);
	var v = ax * bw1 + ay * bz1;
	out[0] = v;
	var v = ay * bw1 - ax * bz1;
	out[1] = v;
	var v = az * bw1 + aw * bz1;
	out[2] = v;
	var v = aw * bw1 - az * bz1;
	out[3] = v;
	bx = out[0];
	by = out[1];
	bz = out[2];
	bw = out[3];
	var v = ax1 * bw + aw1 * bx + ay1 * bz - az1 * by;
	out[4] = v;
	var v = ay1 * bw + aw1 * by + az1 * bx - ax1 * bz;
	out[5] = v;
	var v = az1 * bw + aw1 * bz + ax1 * by - ay1 * bx;
	out[6] = v;
	var v = aw1 * bw - ax1 * bx - ay1 * by - az1 * bz;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateByQuatAppend = function(a,q,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var qx = q[0];
	var qy = q[1];
	var qz = q[2];
	var qw = q[3];
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var v = ax * qw + aw * qx + ay * qz - az * qy;
	out[0] = v;
	var v = ay * qw + aw * qy + az * qx - ax * qz;
	out[1] = v;
	var v = az * qw + aw * qz + ax * qy - ay * qx;
	out[2] = v;
	var v = aw * qw - ax * qx - ay * qy - az * qz;
	out[3] = v;
	ax = a[4];
	ay = a[5];
	az = a[6];
	aw = a[7];
	var v = ax * qw + aw * qx + ay * qz - az * qy;
	out[4] = v;
	var v = ay * qw + aw * qy + az * qx - ax * qz;
	out[5] = v;
	var v = az * qw + aw * qz + ax * qy - ay * qx;
	out[6] = v;
	var v = aw * qw - ax * qx - ay * qy - az * qz;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateByQuatPrepend = function(a,q,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var qx = q[0];
	var qy = q[1];
	var qz = q[2];
	var qw = q[3];
	var bx = a[0];
	var by = a[1];
	var bz = a[2];
	var bw = a[3];
	var v = qx * bw + qw * bx + qy * bz - qz * by;
	out[0] = v;
	var v = qy * bw + qw * by + qz * bx - qx * bz;
	out[1] = v;
	var v = qz * bw + qw * bz + qx * by - qy * bx;
	out[2] = v;
	var v = qw * bw - qx * bx - qy * by - qz * bz;
	out[3] = v;
	bx = a[4];
	by = a[5];
	bz = a[6];
	bw = a[7];
	var v = qx * bw + qw * bx + qy * bz - qz * by;
	out[4] = v;
	var v = qy * bw + qw * by + qz * bx - qx * bz;
	out[5] = v;
	var v = qz * bw + qw * bz + qx * by - qy * bx;
	out[6] = v;
	var v = qw * bw - qx * bx - qy * by - qz * bz;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.rotateAroundAxis = function(a,axis,rad,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	if(Math.abs(rad) < 0.000001) {
		return mme_math_glmatrix_Quat2Tools.copy(out,a);
	}
	var axisLength = Math.sqrt(axis[0] * axis[0] + axis[1] * axis[1] + axis[2] * axis[2]);
	rad *= 0.5;
	var s = Math.sin(rad);
	var bx = s * axis[0] / axisLength;
	var by = s * axis[1] / axisLength;
	var bz = s * axis[2] / axisLength;
	var bw = Math.cos(rad);
	var ax1 = a[0];
	var ay1 = a[1];
	var az1 = a[2];
	var aw1 = a[3];
	var v = ax1 * bw + aw1 * bx + ay1 * bz - az1 * by;
	out[0] = v;
	var v = ay1 * bw + aw1 * by + az1 * bx - ax1 * bz;
	out[1] = v;
	var v = az1 * bw + aw1 * bz + ax1 * by - ay1 * bx;
	out[2] = v;
	var v = aw1 * bw - ax1 * bx - ay1 * by - az1 * bz;
	out[3] = v;
	var ax = a[4];
	var ay = a[5];
	var az = a[6];
	var aw = a[7];
	var v = ax * bw + aw * bx + ay * bz - az * by;
	out[4] = v;
	var v = ay * bw + aw * by + az * bx - ax * bz;
	out[5] = v;
	var v = az * bw + aw * bz + ax * by - ay * bx;
	out[6] = v;
	var v = aw * bw - ax * bx - ay * by - az * bz;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	var v = a[2] + b[2];
	out[2] = v;
	var v = a[3] + b[3];
	out[3] = v;
	var v = a[4] + b[4];
	out[4] = v;
	var v = a[5] + b[5];
	out[5] = v;
	var v = a[6] + b[6];
	out[6] = v;
	var v = a[7] + b[7];
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var ax0 = a[0];
	var ay0 = a[1];
	var az0 = a[2];
	var aw0 = a[3];
	var bx1 = b[4];
	var by1 = b[5];
	var bz1 = b[6];
	var bw1 = b[7];
	var ax1 = a[4];
	var ay1 = a[5];
	var az1 = a[6];
	var aw1 = a[7];
	var bx0 = b[0];
	var by0 = b[1];
	var bz0 = b[2];
	var bw0 = b[3];
	var v = ax0 * bw0 + aw0 * bx0 + ay0 * bz0 - az0 * by0;
	out[0] = v;
	var v = ay0 * bw0 + aw0 * by0 + az0 * bx0 - ax0 * bz0;
	out[1] = v;
	var v = az0 * bw0 + aw0 * bz0 + ax0 * by0 - ay0 * bx0;
	out[2] = v;
	var v = aw0 * bw0 - ax0 * bx0 - ay0 * by0 - az0 * bz0;
	out[3] = v;
	var v = ax0 * bw1 + aw0 * bx1 + ay0 * bz1 - az0 * by1 + ax1 * bw0 + aw1 * bx0 + ay1 * bz0 - az1 * by0;
	out[4] = v;
	var v = ay0 * bw1 + aw0 * by1 + az0 * bx1 - ax0 * bz1 + ay1 * bw0 + aw1 * by0 + az1 * bx0 - ax1 * bz0;
	out[5] = v;
	var v = az0 * bw1 + aw0 * bz1 + ax0 * by1 - ay0 * bx1 + az1 * bw0 + aw1 * bz0 + ax1 * by0 - ay1 * bx0;
	out[6] = v;
	var v = aw0 * bw1 - ax0 * bx1 - ay0 * by1 - az0 * bz1 + aw1 * bw0 - ax1 * bx0 - ay1 * by0 - az1 * bz0;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.scale = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	var v = a[2] * b;
	out[2] = v;
	var v = a[3] * b;
	out[3] = v;
	var v = a[4] * b;
	out[4] = v;
	var v = a[5] * b;
	out[5] = v;
	var v = a[6] * b;
	out[6] = v;
	var v = a[7] * b;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.dot = function(a,b) {
	return a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
};
mme_math_glmatrix_Quat2Tools.lerp = function(t,a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var mt = 1 - t;
	if(mme_math_glmatrix_Quat2Tools.dot(a,b) < 0) {
		t = -t;
	}
	var v = a[0] * mt + b[0] * t;
	out[0] = v;
	var v = a[1] * mt + b[1] * t;
	out[1] = v;
	var v = a[2] * mt + b[2] * t;
	out[2] = v;
	var v = a[3] * mt + b[3] * t;
	out[3] = v;
	var v = a[4] * mt + b[4] * t;
	out[4] = v;
	var v = a[5] * mt + b[5] * t;
	out[5] = v;
	var v = a[6] * mt + b[6] * t;
	out[6] = v;
	var v = a[7] * mt + b[7] * t;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.invert = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var sqlen = mme_math_glmatrix_Quat2Tools.squaredLength(a);
	var v = -a[0] / sqlen;
	out[0] = v;
	var v = -a[1] / sqlen;
	out[1] = v;
	var v = -a[2] / sqlen;
	out[2] = v;
	var v = a[3] / sqlen;
	out[3] = v;
	var v = -a[4] / sqlen;
	out[4] = v;
	var v = -a[5] / sqlen;
	out[5] = v;
	var v = -a[6] / sqlen;
	out[6] = v;
	var v = a[7] / sqlen;
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.conjugate = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var v = -a[0];
	out[0] = v;
	var v = -a[1];
	out[1] = v;
	var v = -a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	var v = -a[4];
	out[4] = v;
	var v = -a[5];
	out[5] = v;
	var v = -a[6];
	out[6] = v;
	var v = a[7];
	out[7] = v;
	return out;
};
mme_math_glmatrix_Quat2Tools.$length = function(a) {
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	return Math.sqrt(x * x + y * y + z * z + w * w);
};
mme_math_glmatrix_Quat2Tools.squaredLength = function(a) {
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	return x * x + y * y + z * z + w * w;
};
mme_math_glmatrix_Quat2Tools.normalize = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[4] = 0.0;
		this2[5] = 0.0;
		this2[6] = 0.0;
		this2[7] = 0.0;
		this2[3] = 1.0;
		var dq = this2;
		out = dq;
	}
	var magnitude = mme_math_glmatrix_Quat2Tools.squaredLength(a);
	if(magnitude > 0) {
		magnitude = Math.sqrt(magnitude);
		var a0 = a[0] / magnitude;
		var a1 = a[1] / magnitude;
		var a2 = a[2] / magnitude;
		var a3 = a[3] / magnitude;
		var b0 = a[4];
		var b1 = a[5];
		var b2 = a[6];
		var b3 = a[7];
		var a_dot_b = a0 * b0 + a1 * b1 + a2 * b2 + a3 * b3;
		out[0] = a0;
		out[1] = a1;
		out[2] = a2;
		out[3] = a3;
		var v = (b0 - a0 * a_dot_b) / magnitude;
		out[4] = v;
		var v = (b1 - a1 * a_dot_b) / magnitude;
		out[5] = v;
		var v = (b2 - a2 * a_dot_b) / magnitude;
		out[6] = v;
		var v = (b3 - a3 * a_dot_b) / magnitude;
		out[7] = v;
	}
	return out;
};
mme_math_glmatrix_Quat2Tools.str = function(a) {
	return "Quat2(" + a[0] + ", " + a[1] + ", " + a[2] + ", " + a[3] + ", " + a[4] + ", " + a[5] + ", " + a[6] + ", " + a[7] + ")";
};
mme_math_glmatrix_Quat2Tools.exactEquals = function(a,b) {
	if(a[0] == b[0] && a[1] == b[1] && a[2] == b[2] && a[3] == b[3] && a[4] == b[4] && a[5] == b[5] && a[6] == b[6]) {
		return a[7] == b[7];
	} else {
		return false;
	}
};
mme_math_glmatrix_Quat2Tools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var a4 = a[4];
	var a5 = a[5];
	var a6 = a[6];
	var a7 = a[7];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	var b4 = b[4];
	var b5 = b[5];
	var b6 = b[6];
	var b7 = b[7];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0))) && Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1))) && Math.abs(a2 - b2) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a2),Math.abs(b2))) && Math.abs(a3 - b3) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a3),Math.abs(b3))) && Math.abs(a4 - b4) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a4),Math.abs(b4))) && Math.abs(a5 - b5) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a5),Math.abs(b5))) && Math.abs(a6 - b6) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a6),Math.abs(b6)))) {
		return Math.abs(a7 - b7) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a7),Math.abs(b7)));
	} else {
		return false;
	}
};
var mme_math_glmatrix_QuatTools = function() { };
mme_math_glmatrix_QuatTools.__name__ = true;
mme_math_glmatrix_QuatTools.create = function() {
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 1.0;
	var out = this2;
	return out;
};
mme_math_glmatrix_QuatTools.identity = function(out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = 0;
	out[1] = 0;
	out[2] = 0;
	out[3] = 1;
	return out;
};
mme_math_glmatrix_QuatTools.getAxisAngle = function(a,out_axis) {
	var rad = Math.acos(a[3]) * 2.0;
	var s = Math.sin(rad / 2.0);
	if(s > 0.000001) {
		var v = a[0] / s;
		out_axis[0] = v;
		var v = a[1] / s;
		out_axis[1] = v;
		var v = a[2] / s;
		out_axis[2] = v;
	} else {
		out_axis[0] = 1;
		out_axis[1] = 0;
		out_axis[2] = 0;
	}
	return rad;
};
mme_math_glmatrix_QuatTools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var bx = b[0];
	var by = b[1];
	var bz = b[2];
	var bw = b[3];
	var v = ax * bw + aw * bx + ay * bz - az * by;
	out[0] = v;
	var v = ay * bw + aw * by + az * bx - ax * bz;
	out[1] = v;
	var v = az * bw + aw * bz + ax * by - ay * bx;
	out[2] = v;
	var v = aw * bw - ax * bx - ay * by - az * bz;
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.rotateX = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	rad *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var bx = Math.sin(rad);
	var bw = Math.cos(rad);
	var v = ax * bw + aw * bx;
	out[0] = v;
	var v = ay * bw + az * bx;
	out[1] = v;
	var v = az * bw - ay * bx;
	out[2] = v;
	var v = aw * bw - ax * bx;
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.rotateY = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	rad *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var by = Math.sin(rad);
	var bw = Math.cos(rad);
	var v = ax * bw - az * by;
	out[0] = v;
	var v = ay * bw + aw * by;
	out[1] = v;
	var v = az * bw + ax * by;
	out[2] = v;
	var v = aw * bw - ay * by;
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.rotateZ = function(a,rad,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	rad *= 0.5;
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var bz = Math.sin(rad);
	var bw = Math.cos(rad);
	var v = ax * bw + ay * bz;
	out[0] = v;
	var v = ay * bw - ax * bz;
	out[1] = v;
	var v = az * bw + aw * bz;
	out[2] = v;
	var v = aw * bw - az * bz;
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.calculateW = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var z = a[2];
	out[0] = x;
	out[1] = y;
	out[2] = z;
	var v = Math.sqrt(Math.abs(1.0 - x * x - y * y - z * z));
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.slerp = function(t,a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var bx = b[0];
	var by = b[1];
	var bz = b[2];
	var bw = b[3];
	var omega;
	var sinom;
	var scale0;
	var scale1;
	var cosom = ax * bx + ay * by + az * bz + aw * bw;
	if(cosom < 0.0) {
		cosom = -cosom;
		bx = -bx;
		by = -by;
		bz = -bz;
		bw = -bw;
	}
	if(1.0 - cosom > 0.000001) {
		omega = Math.acos(cosom);
		sinom = Math.sin(omega);
		scale0 = Math.sin((1.0 - t) * omega) / sinom;
		scale1 = Math.sin(t * omega) / sinom;
	} else {
		scale0 = 1.0 - t;
		scale1 = t;
	}
	var v = scale0 * ax + scale1 * bx;
	out[0] = v;
	var v = scale0 * ay + scale1 * by;
	out[1] = v;
	var v = scale0 * az + scale1 * bz;
	out[2] = v;
	var v = scale0 * aw + scale1 * bw;
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.random = function(out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var u1 = mme_math_glmatrix_GLMatrix.RANDOM();
	var u2 = mme_math_glmatrix_GLMatrix.RANDOM();
	var u3 = mme_math_glmatrix_GLMatrix.RANDOM();
	var sqrt1MinusU1 = Math.sqrt(1 - u1);
	var sqrtU1 = Math.sqrt(u1);
	var v = sqrt1MinusU1 * Math.sin(2.0 * Math.PI * u2);
	out[0] = v;
	var v = sqrt1MinusU1 * Math.cos(2.0 * Math.PI * u2);
	out[1] = v;
	var v = sqrtU1 * Math.sin(2.0 * Math.PI * u3);
	out[2] = v;
	var v = sqrtU1 * Math.cos(2.0 * Math.PI * u3);
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.invert = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var dot = a0 * a0 + a1 * a1 + a2 * a2 + a3 * a3;
	var invDot = dot != 0.0 ? 1.0 / dot : 0.0;
	var v = -a0 * invDot;
	out[0] = v;
	var v = -a1 * invDot;
	out[1] = v;
	var v = -a2 * invDot;
	out[2] = v;
	var v = a3 * invDot;
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.conjugate = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = -a[0];
	out[0] = v;
	var v = -a[1];
	out[1] = v;
	var v = -a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.str = function(a) {
	return "Quat(" + a[0] + ", " + a[1] + ", " + a[2] + ", " + a[3] + ")";
};
mme_math_glmatrix_QuatTools.clone = function(a) {
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 1.0;
	var out = this2;
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.set = function(out,x,y,z,w) {
	out[0] = x;
	out[1] = y;
	out[2] = z;
	out[3] = w;
	return out;
};
mme_math_glmatrix_QuatTools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	var v = a[2] + b[2];
	out[2] = v;
	var v = a[3] + b[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.multiplyVec3 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var qx = a[0];
	var qy = a[1];
	var qz = a[2];
	var qw = a[3];
	var x = v[0];
	var y = v[1];
	var z = v[2];
	var uvx = qy * z - qz * y;
	var uvy = qz * x - qx * z;
	var uvz = qx * y - qy * x;
	var uuvx = qy * uvz - qz * uvy;
	var uuvy = qz * uvx - qx * uvz;
	var uuvz = qx * uvy - qy * uvx;
	var w2 = qw * 2;
	uvx *= w2;
	uvy *= w2;
	uvz *= w2;
	uuvx *= 2;
	uuvy *= 2;
	uuvz *= 2;
	var v = x + uvx + uuvx;
	out[0] = v;
	var v = y + uvy + uuvy;
	out[1] = v;
	var v = z + uvz + uuvz;
	out[2] = v;
	return out;
};
mme_math_glmatrix_QuatTools.multiplyVec4 = function(a,v,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = v[0];
	var y = v[1];
	var z = v[2];
	var qx = a[0];
	var qy = a[1];
	var qz = a[2];
	var qw = a[3];
	var ix = qw * x + qy * z - qz * y;
	var iy = qw * y + qz * x - qx * z;
	var iz = qw * z + qx * y - qy * x;
	var iw = -qx * x - qy * y - qz * z;
	var v1 = ix * qw + iw * -qx + iy * -qz - iz * -qy;
	out[0] = v1;
	var v1 = iy * qw + iw * -qy + iz * -qx - ix * -qz;
	out[1] = v1;
	var v1 = iz * qw + iw * -qz + ix * -qy - iy * -qx;
	out[2] = v1;
	var v1 = v[3];
	out[3] = v1;
	return out;
};
mme_math_glmatrix_QuatTools.scale = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	var v = a[2] * b;
	out[2] = v;
	var v = a[3] * b;
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.dot = function(a,b) {
	return a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
};
mme_math_glmatrix_QuatTools.lerp = function(t,a,b,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var v = ax + t * (b[0] - ax);
	out[0] = v;
	var v = ay + t * (b[1] - ay);
	out[1] = v;
	var v = az + t * (b[2] - az);
	out[2] = v;
	var v = aw + t * (b[3] - aw);
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.$length = function(a) {
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	return Math.sqrt(x * x + y * y + z * z + w * w);
};
mme_math_glmatrix_QuatTools.squaredLength = function(a) {
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	return x * x + y * y + z * z + w * w;
};
mme_math_glmatrix_QuatTools.normalize = function(a,out) {
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	var len = x * x + y * y + z * z + w * w;
	if(len > 0) {
		len = 1 / Math.sqrt(len);
	}
	var v = x * len;
	out[0] = v;
	var v = y * len;
	out[1] = v;
	var v = z * len;
	out[2] = v;
	var v = w * len;
	out[3] = v;
	return out;
};
mme_math_glmatrix_QuatTools.exactEquals = function(a,b) {
	if(a[0] == b[0] && a[1] == b[1] && a[2] == b[2]) {
		return a[3] == b[3];
	} else {
		return false;
	}
};
mme_math_glmatrix_QuatTools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0))) && Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1))) && Math.abs(a2 - b2) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a2),Math.abs(b2)))) {
		return Math.abs(a3 - b3) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a3),Math.abs(b3)));
	} else {
		return false;
	}
};
mme_math_glmatrix_QuatTools.rotationTo = function(out,a,b) {
	var this1 = new Array(3);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	var out1 = this2;
	var tmpvec3 = out1;
	var xUnitVec3 = mme_math_glmatrix_Vec3.fromValues(null,1,0,0);
	var yUnitVec3 = mme_math_glmatrix_Vec3.fromValues(null,0,1,0);
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	var dot = mme_math_glmatrix_Vec3Tools.dot(a,b);
	if(dot < -0.999999) {
		mme_math_glmatrix_Vec3Tools.cross(tmpvec3,xUnitVec3,a);
		if(mme_math_glmatrix_Vec3Tools.len(tmpvec3) < 0.000001) {
			mme_math_glmatrix_Vec3Tools.cross(tmpvec3,yUnitVec3,a);
		}
		mme_math_glmatrix_Vec3Tools.normalize(tmpvec3,tmpvec3);
		mme_math_glmatrix_Quat.fromAxisAngle(out,tmpvec3,Math.PI);
		return out;
	} else if(dot > 0.999999) {
		out[0] = 0;
		out[1] = 0;
		out[2] = 0;
		out[3] = 1;
		return out;
	} else {
		mme_math_glmatrix_Vec3Tools.cross(tmpvec3,a,b);
		var v = tmpvec3[0];
		out[0] = v;
		var v = tmpvec3[1];
		out[1] = v;
		var v = tmpvec3[2];
		out[2] = v;
		var v = 1 + dot;
		out[3] = v;
		return mme_math_glmatrix_QuatTools.normalize(out,out);
	}
};
mme_math_glmatrix_QuatTools.sqlerp = function(t,a,b,c,d,out) {
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 1.0;
	var out1 = this2;
	var temp1 = out1;
	var this1 = new Array(9);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 1.0;
	var out1 = this2;
	var temp2 = out1;
	if(out == null) {
		var this1 = new Array(9);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 1.0;
		var out1 = this2;
		out = out1;
	}
	mme_math_glmatrix_QuatTools.slerp(t,a,d,temp1);
	mme_math_glmatrix_QuatTools.slerp(t,b,c,temp2);
	mme_math_glmatrix_QuatTools.slerp(2 * t * (1 - t),temp1,temp2,out);
	return out;
};
var mme_math_glmatrix_Vec2 = {};
mme_math_glmatrix_Vec2._new = function() {
	var this1 = new Array(2);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	return this2;
};
mme_math_glmatrix_Vec2.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Vec2.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Vec2.get_x = function(this1) {
	return this1[0];
};
mme_math_glmatrix_Vec2.set_x = function(this1,x) {
	return this1[0] = x;
};
mme_math_glmatrix_Vec2.get_y = function(this1) {
	return this1[1];
};
mme_math_glmatrix_Vec2.set_y = function(this1,y) {
	return this1[1] = y;
};
mme_math_glmatrix_Vec2.fromArray = function(a) {
	return mme_math_glmatrix_Vec2.fromValues(null,a[0],a[1]);
};
mme_math_glmatrix_Vec2.toArray = function(this1) {
	return [this1[0],this1[1]];
};
mme_math_glmatrix_Vec2.toString = function(this1) {
	return mme_math_glmatrix_Vec2Tools.str(this1);
};
mme_math_glmatrix_Vec2.fromValues = function(out,x,y) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = x;
	out[1] = y;
	return out;
};
var mme_math_glmatrix_Vec2Tools = function() { };
mme_math_glmatrix_Vec2Tools.__name__ = true;
mme_math_glmatrix_Vec2Tools.create = function() {
	var this1 = new Array(2);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	var out = this2;
	return out;
};
mme_math_glmatrix_Vec2Tools.clone = function(a) {
	var this1 = new Array(2);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	var out = this2;
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.set = function(out,x,y) {
	out[0] = x;
	out[1] = y;
	return out;
};
mme_math_glmatrix_Vec2Tools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.subtract = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] - b[0];
	out[0] = v;
	var v = a[1] - b[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b[0];
	out[0] = v;
	var v = a[1] * b[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.divide = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] / b[0];
	out[0] = v;
	var v = a[1] / b[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.ceil = function(a,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.ceil(a[0]);
	out[0] = v;
	var v = Math.ceil(a[1]);
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.floor = function(a,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.floor(a[0]);
	out[0] = v;
	var v = Math.floor(a[1]);
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.min = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.min(a[0],b[0]);
	out[0] = v;
	var v = Math.min(a[1],b[1]);
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.max = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.max(a[0],b[0]);
	out[0] = v;
	var v = Math.max(a[1],b[1]);
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.round = function(a,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.round(a[0]);
	out[0] = v;
	var v = Math.round(a[1]);
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.scale = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.scaleAndAdd = function(a,b,scale,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0] * scale;
	out[0] = v;
	var v = a[1] + b[1] * scale;
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.distance = function(a,b) {
	var x = b[0] - a[0];
	var y = b[1] - a[1];
	return Math.sqrt(x * x + y * y);
};
mme_math_glmatrix_Vec2Tools.squaredDistance = function(a,b) {
	var x = b[0] - a[0];
	var y = b[1] - a[1];
	return x * x + y * y;
};
mme_math_glmatrix_Vec2Tools.$length = function(a) {
	var x = a[0];
	var y = a[1];
	return Math.sqrt(x * x + y * y);
};
mme_math_glmatrix_Vec2Tools.squaredLength = function(a) {
	var x = a[0];
	var y = a[1];
	return x * x + y * y;
};
mme_math_glmatrix_Vec2Tools.negate = function(a,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = -a[0];
	out[0] = v;
	var v = -a[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.inverse = function(a,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = 1.0 / a[0];
	out[0] = v;
	var v = 1.0 / a[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.normalize = function(a,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var len = x * x + y * y;
	if(len > 0) {
		len = 1 / Math.sqrt(len);
	}
	var v = a[0] * len;
	out[0] = v;
	var v = a[1] * len;
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.dot = function(a,b) {
	return a[0] * b[0] + a[1] * b[1];
};
mme_math_glmatrix_Vec2Tools.cross = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		out = this2;
	}
	var z = a[0] * b[1] - a[1] * b[0];
	out[1] = 0;
	var v = 0;
	out[0] = v;
	out[2] = z;
	return out;
};
mme_math_glmatrix_Vec2Tools.lerp = function(t,a,b,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var ax = a[0];
	var ay = a[1];
	var v = ax + t * (b[0] - ax);
	out[0] = v;
	var v = ay + t * (b[1] - ay);
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.random = function(out,scale) {
	if(scale == null) {
		scale = 1.0;
	}
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var r = mme_math_glmatrix_GLMatrix.RANDOM() * 2.0 * Math.PI;
	var v = Math.cos(r) * scale;
	out[0] = v;
	var v = Math.sin(r) * scale;
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.postmultiplyMat2 = function(a,m,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var v = m[0] * x + m[2] * y;
	out[0] = v;
	var v = m[1] * x + m[3] * y;
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.postmultiplyMat2d = function(a,m,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var v = m[0] * x + m[2] * y + m[4];
	out[0] = v;
	var v = m[1] * x + m[3] * y + m[5];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.postmultiplyMat3 = function(a,m,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var v = m[0] * x + m[3] * y + m[6];
	out[0] = v;
	var v = m[1] * x + m[4] * y + m[7];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.postmultiplyMat4 = function(a,m,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var v = m[0] * x + m[4] * y + m[12];
	out[0] = v;
	var v = m[1] * x + m[5] * y + m[13];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.rotate = function(a,b,c,out) {
	if(out == null) {
		var this1 = new Array(2);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		var out1 = this2;
		out = out1;
	}
	if(b == null) {
		b = mme_math_glmatrix_Vec2.fromArray([0,0]);
	}
	var p0 = a[0] - b[0];
	var p1 = a[1] - b[1];
	var sinC = Math.sin(c);
	var cosC = Math.cos(c);
	var v = p0 * cosC - p1 * sinC + b[0];
	out[0] = v;
	var v = p0 * sinC + p1 * cosC + b[1];
	out[1] = v;
	return out;
};
mme_math_glmatrix_Vec2Tools.angle = function(a,b) {
	var x1 = a[0];
	var y1 = a[1];
	var x2 = b[0];
	var y2 = b[1];
	var len1 = x1 * x1 + y1 * y1;
	if(len1 > 0) {
		len1 = 1 / Math.sqrt(len1);
	}
	var len2 = x2 * x2 + y2 * y2;
	if(len2 > 0) {
		len2 = 1 / Math.sqrt(len2);
	}
	var cosine = (x1 * x2 + y1 * y2) * len1 * len2;
	if(cosine > 1.0) {
		return 0;
	} else if(cosine < -1.0) {
		return Math.PI;
	} else {
		return Math.acos(cosine);
	}
};
mme_math_glmatrix_Vec2Tools.zero = function(out) {
	out[0] = 0.0;
	out[1] = 0.0;
	return out;
};
mme_math_glmatrix_Vec2Tools.str = function(a) {
	return "Vec2(" + a[0] + ", " + a[1] + ")";
};
mme_math_glmatrix_Vec2Tools.exactEquals = function(a,b) {
	if(a[0] == b[0]) {
		return a[1] == b[1];
	} else {
		return false;
	}
};
mme_math_glmatrix_Vec2Tools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var b0 = b[0];
	var b1 = b[1];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0)))) {
		return Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1)));
	} else {
		return false;
	}
};
var mme_math_glmatrix_Vec3 = {};
mme_math_glmatrix_Vec3._new = function() {
	var this1 = new Array(3);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	return this2;
};
mme_math_glmatrix_Vec3.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Vec3.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Vec3.get_x = function(this1) {
	return this1[0];
};
mme_math_glmatrix_Vec3.set_x = function(this1,x) {
	return this1[0] = x;
};
mme_math_glmatrix_Vec3.get_y = function(this1) {
	return this1[1];
};
mme_math_glmatrix_Vec3.set_y = function(this1,y) {
	return this1[1] = y;
};
mme_math_glmatrix_Vec3.get_z = function(this1) {
	return this1[2];
};
mme_math_glmatrix_Vec3.set_z = function(this1,z) {
	return this1[2] = z;
};
mme_math_glmatrix_Vec3.fromArray = function(a) {
	return mme_math_glmatrix_Vec3.fromValues(null,a[0],a[1],a[2]);
};
mme_math_glmatrix_Vec3.toArray = function(this1) {
	return [this1[0],this1[1],this1[2]];
};
mme_math_glmatrix_Vec3.toString = function(this1) {
	return mme_math_glmatrix_Vec3Tools.str(this1);
};
mme_math_glmatrix_Vec3.get_X_AXIS = function() {
	return mme_math_glmatrix_Vec3.fromArray([1,0,0]);
};
mme_math_glmatrix_Vec3.get_Y_AXIS = function() {
	return mme_math_glmatrix_Vec3.fromArray([0,1,0]);
};
mme_math_glmatrix_Vec3.get_Z_AXIS = function() {
	return mme_math_glmatrix_Vec3.fromArray([0,0,1]);
};
mme_math_glmatrix_Vec3.fromValues = function(out,x,y,z) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = x;
	out[1] = y;
	out[2] = z;
	return out;
};
var mme_math_glmatrix_Vec3Tools = function() { };
mme_math_glmatrix_Vec3Tools.__name__ = true;
mme_math_glmatrix_Vec3Tools.create = function() {
	var this1 = new Array(3);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	var out = this2;
	return out;
};
mme_math_glmatrix_Vec3Tools.clone = function(a) {
	var this1 = new Array(3);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	var out = this2;
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.$length = function(a) {
	var x = a[0];
	var y = a[1];
	var z = a[2];
	return Math.sqrt(x * x + y * y + z * z);
};
mme_math_glmatrix_Vec3Tools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.set = function(out,x,y,z) {
	out[0] = x;
	out[1] = y;
	out[2] = z;
	return out;
};
mme_math_glmatrix_Vec3Tools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	var v = a[2] + b[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.subtract = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] - b[0];
	out[0] = v;
	var v = a[1] - b[1];
	out[1] = v;
	var v = a[2] - b[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b[0];
	out[0] = v;
	var v = a[1] * b[1];
	out[1] = v;
	var v = a[2] * b[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.divide = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] / b[0];
	out[0] = v;
	var v = a[1] / b[1];
	out[1] = v;
	var v = a[2] / b[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.ceil = function(a,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.ceil(a[0]);
	out[0] = v;
	var v = Math.ceil(a[1]);
	out[1] = v;
	var v = Math.ceil(a[2]);
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.floor = function(a,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.floor(a[0]);
	out[0] = v;
	var v = Math.floor(a[1]);
	out[1] = v;
	var v = Math.floor(a[2]);
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.min = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.min(a[0],b[0]);
	out[0] = v;
	var v = Math.min(a[1],b[1]);
	out[1] = v;
	var v = Math.min(a[2],b[2]);
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.max = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.max(a[0],b[0]);
	out[0] = v;
	var v = Math.max(a[1],b[1]);
	out[1] = v;
	var v = Math.max(a[2],b[2]);
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.round = function(a,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.round(a[0]);
	out[0] = v;
	var v = Math.round(a[1]);
	out[1] = v;
	var v = Math.round(a[2]);
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.scale = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	var v = a[2] * b;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.scaleAndAdd = function(a,b,scale,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0] * scale;
	out[0] = v;
	var v = a[1] + b[1] * scale;
	out[1] = v;
	var v = a[2] + b[2] * scale;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.distance = function(a,b) {
	var x = b[0] - a[0];
	var y = b[1] - a[1];
	var z = b[2] - a[2];
	return Math.sqrt(x * x + y * y + z * z);
};
mme_math_glmatrix_Vec3Tools.squaredDistance = function(a,b) {
	var x = b[0] - a[0];
	var y = b[1] - a[1];
	var z = b[2] - a[2];
	return x * x + y * y + z * z;
};
mme_math_glmatrix_Vec3Tools.squaredLength = function(a) {
	var x = a[0];
	var y = a[1];
	var z = a[2];
	return x * x + y * y + z * z;
};
mme_math_glmatrix_Vec3Tools.negate = function(a,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = -a[0];
	out[0] = v;
	var v = -a[1];
	out[1] = v;
	var v = -a[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.inverse = function(a,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = 1.0 / a[0];
	out[0] = v;
	var v = 1.0 / a[1];
	out[1] = v;
	var v = 1.0 / a[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.normalize = function(a,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var len = x * x + y * y + z * z;
	if(len > 0) {
		len = 1 / Math.sqrt(len);
	}
	var v = a[0] * len;
	out[0] = v;
	var v = a[1] * len;
	out[1] = v;
	var v = a[2] * len;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.dot = function(a,b) {
	return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
};
mme_math_glmatrix_Vec3Tools.cross = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var bx = b[0];
	var by = b[1];
	var bz = b[2];
	var v = ay * bz - az * by;
	out[0] = v;
	var v = az * bx - ax * bz;
	out[1] = v;
	var v = ax * by - ay * bx;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.lerp = function(t,a,b,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var v = ax + t * (b[0] - ax);
	out[0] = v;
	var v = ay + t * (b[1] - ay);
	out[1] = v;
	var v = az + t * (b[2] - az);
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.hermite = function(t,a,b,c,d,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var factorTimes2 = t * t;
	var factor1 = factorTimes2 * (2 * t - 3) + 1;
	var factor2 = factorTimes2 * (t - 2) + t;
	var factor3 = factorTimes2 * (t - 1);
	var factor4 = factorTimes2 * (3 - 2 * t);
	var v = a[0] * factor1 + b[0] * factor2 + c[0] * factor3 + d[0] * factor4;
	out[0] = v;
	var v = a[1] * factor1 + b[1] * factor2 + c[1] * factor3 + d[1] * factor4;
	out[1] = v;
	var v = a[2] * factor1 + b[2] * factor2 + c[2] * factor3 + d[2] * factor4;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.bezier = function(t,a,b,c,d,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var inverseFactor = 1 - t;
	var inverseFactorTimesTwo = inverseFactor * inverseFactor;
	var factorTimes2 = t * t;
	var factor1 = inverseFactorTimesTwo * inverseFactor;
	var factor2 = 3 * t * inverseFactorTimesTwo;
	var factor3 = 3 * factorTimes2 * inverseFactor;
	var factor4 = factorTimes2 * t;
	var v = a[0] * factor1 + b[0] * factor2 + c[0] * factor3 + d[0] * factor4;
	out[0] = v;
	var v = a[1] * factor1 + b[1] * factor2 + c[1] * factor3 + d[1] * factor4;
	out[1] = v;
	var v = a[2] * factor1 + b[2] * factor2 + c[2] * factor3 + d[2] * factor4;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.random = function(out,scale) {
	if(scale == null) {
		scale = 1.0;
	}
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var r = mme_math_glmatrix_GLMatrix.RANDOM() * 2.0 * Math.PI;
	var z = mme_math_glmatrix_GLMatrix.RANDOM() * 2.0 - 1.0;
	var zScale = Math.sqrt(1.0 - z * z) * scale;
	var v = Math.cos(r) * zScale;
	out[0] = v;
	var v = Math.sin(r) * zScale;
	out[1] = v;
	var v = z * scale;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.postmultiplyMat4 = function(a,m,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = m[3] * x + m[7] * y + m[11] * z + m[15];
	if(w == 0.0) {
		w = 1.0;
	}
	var v = (m[0] * x + m[4] * y + m[8] * z + m[12]) / w;
	out[0] = v;
	var v = (m[1] * x + m[5] * y + m[9] * z + m[13]) / w;
	out[1] = v;
	var v = (m[2] * x + m[6] * y + m[10] * z + m[14]) / w;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.postmultiplyMat3 = function(a,m,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var v = x * m[0] + y * m[3] + z * m[6];
	out[0] = v;
	var v = x * m[1] + y * m[4] + z * m[7];
	out[1] = v;
	var v = x * m[2] + y * m[5] + z * m[8];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.postmultiplyQuat = function(a,q,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var qx = q[0];
	var qy = q[1];
	var qz = q[2];
	var qw = q[3];
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var uvx = qy * z - qz * y;
	var uvy = qz * x - qx * z;
	var uvz = qx * y - qy * x;
	var uuvx = qy * uvz - qz * uvy;
	var uuvy = qz * uvx - qx * uvz;
	var uuvz = qx * uvy - qy * uvx;
	var w2 = qw * 2;
	uvx *= w2;
	uvy *= w2;
	uvz *= w2;
	uuvx *= 2;
	uuvy *= 2;
	uuvz *= 2;
	var v = x + uvx + uuvx;
	out[0] = v;
	var v = y + uvy + uuvy;
	out[1] = v;
	var v = z + uvz + uuvz;
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.rotateX = function(a,b,c,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var p = [];
	var r = [];
	p[0] = a[0] - b[0];
	p[1] = a[1] - b[1];
	p[2] = a[2] - b[2];
	r[0] = p[0];
	r[1] = p[1] * Math.cos(c) - p[2] * Math.sin(c);
	r[2] = p[1] * Math.sin(c) + p[2] * Math.cos(c);
	var v = r[0] + b[0];
	out[0] = v;
	var v = r[1] + b[1];
	out[1] = v;
	var v = r[2] + b[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.rotateY = function(a,b,c,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var p = [];
	var r = [];
	p[0] = a[0] - b[0];
	p[1] = a[1] - b[1];
	p[2] = a[2] - b[2];
	r[0] = p[2] * Math.sin(c) + p[0] * Math.cos(c);
	r[1] = p[1];
	r[2] = p[2] * Math.cos(c) - p[0] * Math.sin(c);
	var v = r[0] + b[0];
	out[0] = v;
	var v = r[1] + b[1];
	out[1] = v;
	var v = r[2] + b[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.rotateZ = function(a,b,c,out) {
	if(out == null) {
		var this1 = new Array(3);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var p = [];
	var r = [];
	p[0] = a[0] - b[0];
	p[1] = a[1] - b[1];
	p[2] = a[2] - b[2];
	r[0] = p[0] * Math.cos(c) - p[1] * Math.sin(c);
	r[1] = p[0] * Math.sin(c) + p[1] * Math.cos(c);
	r[2] = p[2];
	var v = r[0] + b[0];
	out[0] = v;
	var v = r[1] + b[1];
	out[1] = v;
	var v = r[2] + b[2];
	out[2] = v;
	return out;
};
mme_math_glmatrix_Vec3Tools.angle = function(a,b) {
	var tempA = mme_math_glmatrix_Vec3.fromValues(null,a[0],a[1],a[2]);
	var tempB = mme_math_glmatrix_Vec3.fromValues(null,b[0],b[1],b[2]);
	mme_math_glmatrix_Vec3Tools.normalize(tempA,tempA);
	mme_math_glmatrix_Vec3Tools.normalize(tempB,tempB);
	var cosine = mme_math_glmatrix_Vec3Tools.dot(tempA,tempB);
	if(cosine > 1.0) {
		return 0;
	} else if(cosine < -1.0) {
		return Math.PI;
	} else {
		return Math.acos(cosine);
	}
};
mme_math_glmatrix_Vec3Tools.zero = function(out) {
	out[0] = 0.0;
	out[1] = 0.0;
	out[2] = 0.0;
	return out;
};
mme_math_glmatrix_Vec3Tools.str = function(a) {
	return "Vec3(" + a[0] + ", " + a[1] + ", " + a[2] + ")";
};
mme_math_glmatrix_Vec3Tools.exactEquals = function(a,b) {
	if(a[0] == b[0] && a[1] == b[1]) {
		return a[2] == b[2];
	} else {
		return false;
	}
};
mme_math_glmatrix_Vec3Tools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0))) && Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1)))) {
		return Math.abs(a2 - b2) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a2),Math.abs(b2)));
	} else {
		return false;
	}
};
var mme_math_glmatrix_Vec4 = {};
mme_math_glmatrix_Vec4._new = function() {
	var this1 = new Array(4);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	return this2;
};
mme_math_glmatrix_Vec4.getk = function(this1,key) {
	return this1[key];
};
mme_math_glmatrix_Vec4.setk = function(this1,k,v) {
	this1[k] = v;
	return v;
};
mme_math_glmatrix_Vec4.get_x = function(this1) {
	return this1[0];
};
mme_math_glmatrix_Vec4.set_x = function(this1,x) {
	return this1[0] = x;
};
mme_math_glmatrix_Vec4.get_y = function(this1) {
	return this1[1];
};
mme_math_glmatrix_Vec4.set_y = function(this1,y) {
	return this1[1] = y;
};
mme_math_glmatrix_Vec4.get_z = function(this1) {
	return this1[2];
};
mme_math_glmatrix_Vec4.set_z = function(this1,z) {
	return this1[2] = z;
};
mme_math_glmatrix_Vec4.get_w = function(this1) {
	return this1[3];
};
mme_math_glmatrix_Vec4.set_w = function(this1,w) {
	return this1[3] = w;
};
mme_math_glmatrix_Vec4.fromArray = function(a) {
	return mme_math_glmatrix_Vec4.fromValues(null,a[0],a[1],a[2],a[3]);
};
mme_math_glmatrix_Vec4.toArray = function(this1) {
	return [this1[0],this1[1],this1[2],this1[3]];
};
mme_math_glmatrix_Vec4.toString = function(this1) {
	return mme_math_glmatrix_Vec4Tools.str(this1);
};
mme_math_glmatrix_Vec4.get_X_AXIS = function() {
	return mme_math_glmatrix_Vec4.fromArray([1,0,0,0]);
};
mme_math_glmatrix_Vec4.get_Y_AXIS = function() {
	return mme_math_glmatrix_Vec4.fromArray([0,1,0,0]);
};
mme_math_glmatrix_Vec4.get_Z_AXIS = function() {
	return mme_math_glmatrix_Vec4.fromArray([0,0,1,0]);
};
mme_math_glmatrix_Vec4.fromValues = function(out,x,y,z,w) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	out[0] = x;
	out[1] = y;
	out[2] = z;
	out[3] = w;
	return out;
};
var mme_math_glmatrix_Vec4Tools = function() { };
mme_math_glmatrix_Vec4Tools.__name__ = true;
mme_math_glmatrix_Vec4Tools.create = function() {
	var this1 = new Array(4);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	var out = this2;
	return out;
};
mme_math_glmatrix_Vec4Tools.clone = function(a) {
	var this1 = new Array(4);
	var this2 = this1;
	this2[0] = 0.0;
	this2[1] = 0.0;
	this2[2] = 0.0;
	this2[3] = 0.0;
	var out = this2;
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.copy = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0];
	out[0] = v;
	var v = a[1];
	out[1] = v;
	var v = a[2];
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.set = function(out,x,y,z,w) {
	out[0] = x;
	out[1] = y;
	out[2] = z;
	out[3] = w;
	return out;
};
mme_math_glmatrix_Vec4Tools.add = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0];
	out[0] = v;
	var v = a[1] + b[1];
	out[1] = v;
	var v = a[2] + b[2];
	out[2] = v;
	var v = a[3] + b[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.subtract = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] - b[0];
	out[0] = v;
	var v = a[1] - b[1];
	out[1] = v;
	var v = a[2] - b[2];
	out[2] = v;
	var v = a[3] - b[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.multiply = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b[0];
	out[0] = v;
	var v = a[1] * b[1];
	out[1] = v;
	var v = a[2] * b[2];
	out[2] = v;
	var v = a[3] * b[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.divide = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] / b[0];
	out[0] = v;
	var v = a[1] / b[1];
	out[1] = v;
	var v = a[2] / b[2];
	out[2] = v;
	var v = a[3] / b[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.ceil = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.ceil(a[0]);
	out[0] = v;
	var v = Math.ceil(a[1]);
	out[1] = v;
	var v = Math.ceil(a[2]);
	out[2] = v;
	var v = Math.ceil(a[3]);
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.floor = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.floor(a[0]);
	out[0] = v;
	var v = Math.floor(a[1]);
	out[1] = v;
	var v = Math.floor(a[2]);
	out[2] = v;
	var v = Math.floor(a[3]);
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.min = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.min(a[0],b[0]);
	out[0] = v;
	var v = Math.min(a[1],b[1]);
	out[1] = v;
	var v = Math.min(a[2],b[2]);
	out[2] = v;
	var v = Math.min(a[3],b[3]);
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.max = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.max(a[0],b[0]);
	out[0] = v;
	var v = Math.max(a[1],b[1]);
	out[1] = v;
	var v = Math.max(a[2],b[2]);
	out[2] = v;
	var v = Math.max(a[3],b[3]);
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.round = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = Math.round(a[0]);
	out[0] = v;
	var v = Math.round(a[1]);
	out[1] = v;
	var v = Math.round(a[2]);
	out[2] = v;
	var v = Math.round(a[3]);
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.scale = function(a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] * b;
	out[0] = v;
	var v = a[1] * b;
	out[1] = v;
	var v = a[2] * b;
	out[2] = v;
	var v = a[3] * b;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.scaleAndAdd = function(a,b,scale,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = a[0] + b[0] * scale;
	out[0] = v;
	var v = a[1] + b[1] * scale;
	out[1] = v;
	var v = a[2] + b[2] * scale;
	out[2] = v;
	var v = a[3] + b[3] * scale;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.distance = function(a,b) {
	var x = b[0] - a[0];
	var y = b[1] - a[1];
	var z = b[2] - a[2];
	var w = b[3] - a[3];
	return Math.sqrt(x * x + y * y + z * z + w * w);
};
mme_math_glmatrix_Vec4Tools.squaredDistance = function(a,b) {
	var x = b[0] - a[0];
	var y = b[1] - a[1];
	var z = b[2] - a[2];
	var w = b[3] - a[3];
	return x * x + y * y + z * z + w * w;
};
mme_math_glmatrix_Vec4Tools.$length = function(a) {
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	return Math.sqrt(x * x + y * y + z * z + w * w);
};
mme_math_glmatrix_Vec4Tools.squaredLength = function(a) {
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	return x * x + y * y + z * z + w * w;
};
mme_math_glmatrix_Vec4Tools.negate = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = -a[0];
	out[0] = v;
	var v = -a[1];
	out[1] = v;
	var v = -a[2];
	out[2] = v;
	var v = -a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.inverse = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v = 1.0 / a[0];
	out[0] = v;
	var v = 1.0 / a[1];
	out[1] = v;
	var v = 1.0 / a[2];
	out[2] = v;
	var v = 1.0 / a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.normalize = function(a,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	var len = x * x + y * y + z * z + w * w;
	if(len > 0) {
		len = 1 / Math.sqrt(len);
	}
	var v = x * len;
	out[0] = v;
	var v = y * len;
	out[1] = v;
	var v = z * len;
	out[2] = v;
	var v = w * len;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.dot = function(a,b) {
	return a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
};
mme_math_glmatrix_Vec4Tools.cross = function(u,v,w,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var A = v[0] * w[1] - v[1] * w[0];
	var B = v[0] * w[2] - v[2] * w[0];
	var C = v[0] * w[3] - v[3] * w[0];
	var D = v[1] * w[2] - v[2] * w[1];
	var E = v[1] * w[3] - v[3] * w[1];
	var F = v[2] * w[3] - v[3] * w[2];
	var G = u[0];
	var H = u[1];
	var I = u[2];
	var J = u[3];
	var v = H * F - I * E + J * D;
	out[0] = v;
	var v = -(G * F) + I * C - J * B;
	out[1] = v;
	var v = G * E - H * C + J * A;
	out[2] = v;
	var v = -(G * D) + H * B - I * A;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.lerp = function(t,a,b,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var ax = a[0];
	var ay = a[1];
	var az = a[2];
	var aw = a[3];
	var v = ax + t * (b[0] - ax);
	out[0] = v;
	var v = ay + t * (b[1] - ay);
	out[1] = v;
	var v = az + t * (b[2] - az);
	out[2] = v;
	var v = aw + t * (b[3] - aw);
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.random = function(out,scale) {
	if(scale == null) {
		scale = 1.0;
	}
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var v1;
	var v2;
	var v3;
	var v4;
	var s1;
	var s2;
	while(true) {
		v1 = mme_math_glmatrix_GLMatrix.RANDOM() * 2 - 1;
		v2 = mme_math_glmatrix_GLMatrix.RANDOM() * 2 - 1;
		s1 = v1 * v1 + v2 * v2;
		if(!(s1 >= 1)) {
			break;
		}
	}
	while(true) {
		v3 = mme_math_glmatrix_GLMatrix.RANDOM() * 2 - 1;
		v4 = mme_math_glmatrix_GLMatrix.RANDOM() * 2 - 1;
		s2 = v3 * v3 + v4 * v4;
		if(!(s2 >= 1)) {
			break;
		}
	}
	var d = Math.sqrt((1 - s1) / s2);
	var v = scale * v1;
	out[0] = v;
	var v = scale * v2;
	out[1] = v;
	var v = scale * v3 * d;
	out[2] = v;
	var v = scale * v4 * d;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.postmultiplyMat4 = function(a,m,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var w = a[3];
	var v = m[0] * x + m[4] * y + m[8] * z + m[12] * w;
	out[0] = v;
	var v = m[1] * x + m[5] * y + m[9] * z + m[13] * w;
	out[1] = v;
	var v = m[2] * x + m[6] * y + m[10] * z + m[14] * w;
	out[2] = v;
	var v = m[3] * x + m[7] * y + m[11] * z + m[15] * w;
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.postmultiplyQuat = function(a,q,out) {
	if(out == null) {
		var this1 = new Array(4);
		var this2 = this1;
		this2[0] = 0.0;
		this2[1] = 0.0;
		this2[2] = 0.0;
		this2[3] = 0.0;
		var out1 = this2;
		out = out1;
	}
	var x = a[0];
	var y = a[1];
	var z = a[2];
	var qx = q[0];
	var qy = q[1];
	var qz = q[2];
	var qw = q[3];
	var ix = qw * x + qy * z - qz * y;
	var iy = qw * y + qz * x - qx * z;
	var iz = qw * z + qx * y - qy * x;
	var iw = -qx * x - qy * y - qz * z;
	var v = ix * qw + iw * -qx + iy * -qz - iz * -qy;
	out[0] = v;
	var v = iy * qw + iw * -qy + iz * -qx - ix * -qz;
	out[1] = v;
	var v = iz * qw + iw * -qz + ix * -qy - iy * -qx;
	out[2] = v;
	var v = a[3];
	out[3] = v;
	return out;
};
mme_math_glmatrix_Vec4Tools.zero = function(out) {
	out[0] = 0.0;
	out[1] = 0.0;
	out[2] = 0.0;
	out[3] = 0.0;
	return out;
};
mme_math_glmatrix_Vec4Tools.str = function(a) {
	return "Vec4(" + a[0] + ", " + a[1] + ", " + a[2] + ", " + a[3] + ")";
};
mme_math_glmatrix_Vec4Tools.exactEquals = function(a,b) {
	if(a[0] == b[0] && a[1] == b[1] && a[2] == b[2]) {
		return a[3] == b[3];
	} else {
		return false;
	}
};
mme_math_glmatrix_Vec4Tools.equals = function(a,b) {
	var a0 = a[0];
	var a1 = a[1];
	var a2 = a[2];
	var a3 = a[3];
	var b0 = b[0];
	var b1 = b[1];
	var b2 = b[2];
	var b3 = b[3];
	if(Math.abs(a0 - b0) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a0),Math.abs(b0))) && Math.abs(a1 - b1) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a1),Math.abs(b1))) && Math.abs(a2 - b2) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a2),Math.abs(b2)))) {
		return Math.abs(a3 - b3) <= 0.000001 * Math.max(1.0,Math.max(Math.abs(a3),Math.abs(b3)));
	} else {
		return false;
	}
};
if(typeof(performance) != "undefined" ? typeof(performance.now) == "function" : false) {
	HxOverrides.now = performance.now.bind(performance);
}
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
Date.prototype.__class__ = Date;
Date.__name__ = "Date";
var Int = { };
var Dynamic = { };
var Float = Number;
var Bool = Boolean;
var Class = { };
var Enum = { };
js_Boot.__toStr = ({ }).toString;
libs_webgl_Engine._inst = new libs_webgl_Engine();
mme_math_glmatrix_GLMatrix.EPSILON = 0.000001;
mme_math_glmatrix_GLMatrix.RANDOM = Math.random;
mme_math_glmatrix_GLMatrix.degree = Math.PI / 180.0;
mme_math_glmatrix_Mat2Tools.mul = mme_math_glmatrix_Mat2Tools.multiply;
mme_math_glmatrix_Mat2Tools.sub = mme_math_glmatrix_Mat2Tools.subtract;
mme_math_glmatrix_Mat2dTools.mul = mme_math_glmatrix_Mat2dTools.multiply;
mme_math_glmatrix_Mat2dTools.sub = mme_math_glmatrix_Mat2dTools.subtract;
mme_math_glmatrix_Mat3Tools.mul = mme_math_glmatrix_Mat3Tools.multiply;
mme_math_glmatrix_Mat3Tools.sub = mme_math_glmatrix_Mat3Tools.subtract;
mme_math_glmatrix_Mat4Tools.mul = mme_math_glmatrix_Mat4Tools.multiply;
mme_math_glmatrix_Mat4Tools.sub = mme_math_glmatrix_Mat4Tools.subtract;
mme_math_glmatrix_Quat2Tools.mul = mme_math_glmatrix_Quat2Tools.multiply;
mme_math_glmatrix_Quat2Tools.len = mme_math_glmatrix_Quat2Tools.$length;
mme_math_glmatrix_Quat2Tools.sqrLen = mme_math_glmatrix_Quat2Tools.squaredLength;
mme_math_glmatrix_QuatTools.mul = mme_math_glmatrix_QuatTools.multiply;
mme_math_glmatrix_QuatTools.len = mme_math_glmatrix_QuatTools.$length;
mme_math_glmatrix_QuatTools.sqrLen = mme_math_glmatrix_QuatTools.squaredLength;
mme_math_glmatrix_Vec2Tools.len = mme_math_glmatrix_Vec2Tools.$length;
mme_math_glmatrix_Vec2Tools.sub = mme_math_glmatrix_Vec2Tools.subtract;
mme_math_glmatrix_Vec2Tools.mul = mme_math_glmatrix_Vec2Tools.multiply;
mme_math_glmatrix_Vec2Tools.div = mme_math_glmatrix_Vec2Tools.divide;
mme_math_glmatrix_Vec2Tools.dist = mme_math_glmatrix_Vec2Tools.distance;
mme_math_glmatrix_Vec2Tools.sqrDist = mme_math_glmatrix_Vec2Tools.squaredDistance;
mme_math_glmatrix_Vec2Tools.sqrLen = mme_math_glmatrix_Vec2Tools.squaredLength;
mme_math_glmatrix_Vec3Tools.sub = mme_math_glmatrix_Vec3Tools.subtract;
mme_math_glmatrix_Vec3Tools.mul = mme_math_glmatrix_Vec3Tools.multiply;
mme_math_glmatrix_Vec3Tools.div = mme_math_glmatrix_Vec3Tools.divide;
mme_math_glmatrix_Vec3Tools.dist = mme_math_glmatrix_Vec3Tools.distance;
mme_math_glmatrix_Vec3Tools.sqrDist = mme_math_glmatrix_Vec3Tools.squaredDistance;
mme_math_glmatrix_Vec3Tools.len = mme_math_glmatrix_Vec3Tools.$length;
mme_math_glmatrix_Vec3Tools.sqrLen = mme_math_glmatrix_Vec3Tools.squaredLength;
mme_math_glmatrix_Vec4Tools.sub = mme_math_glmatrix_Vec4Tools.subtract;
mme_math_glmatrix_Vec4Tools.mul = mme_math_glmatrix_Vec4Tools.multiply;
mme_math_glmatrix_Vec4Tools.div = mme_math_glmatrix_Vec4Tools.divide;
mme_math_glmatrix_Vec4Tools.dist = mme_math_glmatrix_Vec4Tools.distance;
mme_math_glmatrix_Vec4Tools.sqrDist = mme_math_glmatrix_Vec4Tools.squaredDistance;
mme_math_glmatrix_Vec4Tools.len = mme_math_glmatrix_Vec4Tools.$length;
mme_math_glmatrix_Vec4Tools.sqrLen = mme_math_glmatrix_Vec4Tools.squaredLength;
Main.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
