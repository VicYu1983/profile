var vic = vic || {};
vic.webgl = vic.webgl || {};
vic.webgl.engine = {};

(function(){
	
	function loadImages(urls, cb) {
		const images = [];
		let imagesToLoad = urls.length;

		function onImageLoad() {
			--imagesToLoad;
			if(imagesToLoad === 0) {
				cb(images);
			}
		}
		for(let i = 0; i < imagesToLoad; ++i) {
			const image = new Image();
			image.src = urls[i];
			image.onload = onImageLoad;
			images.push(image);
		}
	}

	function loadImagesPromise(imageList) {
		return new Promise((resolve, reject) => {
			loadImages(imageList, (images) => {
				resolve(images);
			});
		});
	}

	function loadObjsPromise(objList) {
		return new Promise((resolve, reject) => {
			const objs = [];
			let count = objList.length;

			function onFetchComplete(text) {
				const data = vic.webgl.importer.parseOBJ(text);
				objs.push(data);
				if(--count <= 0) {
					resolve(objs);
				}else{
					loadOneObj();
				}
			}

			function loadOneObj(){
				fetch(objList[objList.length - count]).then((response) => {
					return response.text();
				}).then(onFetchComplete);
			}

			loadOneObj();

			// for(let i = 0; i < objList.length; ++i) {
			// 	fetch(objList[i]).then((response) => {
			// 		return response.text();
			// 	}).then(onFetchComplete);
			// }
		});
	}
	
	async function loadAssets(imageList, objList) {
		const images = await loadImagesPromise(imageList);
		const objs = await loadObjsPromise(objList);
		return new Promise((resolve, reject)=>{
			resolve( [images, objs] );
		});
	}
	
	vic.webgl.engine.nodes = [];
	function addNode(node){
		if( vic.webgl.engine.nodes.indexOf(node) == -1){
			vic.webgl.engine.nodes.push(node);
		}
	}
	
	vic.webgl.engine.materials = [];
	function addMaterial(material){
		if( vic.webgl.engine.materials.indexOf(material) == -1){
			vic.webgl.engine.materials.push(material);
		}
	}
	
	function setMaterials(materials){
		vic.webgl.engine.materials = materials;
	}
	
	function getNodes(){
		let nodes = [];
		for(let i = 0; i < vic.webgl.engine.materials.length; ++i){
			const material = vic.webgl.engine.materials[i];
			nodes = nodes.concat( material.nodes );
		}
		return nodes;
	}
	
	function getProjection(fieldOfView, aspect, near, far) {
		const radian = fieldOfView / 180 * Math.PI;
		var f = Math.tan(Math.PI * 0.5 - 0.5 * radian);
		var rangeInv = 1.0 / (near - far);
		return [
			f / aspect, 0, 0, 0,
			0, f, 0, 0,
			0, 0, (near + far) * rangeInv, -1,
			0, 0, near * far * rangeInv * 2, 0
		];
	}
	
	
	
	function render(currenTime) {
		
		function renderMaterial(material){
			
			const program = material.shader.program;
				
			gl.useProgram(program);
			material.glSetTextureAndUniform();
			
			gl.uniform3fv(material.shader.u_lightColor, [1.,1,1]);
			gl.uniform3fv(material.shader.u_specularColor, [1,1,1]);
			
			gl.uniform3fv(material.shader.u_viewWorldPos, [defaultCamera.pos[0], defaultCamera.pos[1], defaultCamera.pos[2]]);
			gl.uniform3fv(material.shader.u_lightWorldPos, [defaultLight.pos[0], defaultLight.pos[1], defaultLight.pos[2]]);
			
			const nodes = material.nodes;
			for(let key in nodes) {
				const node = nodes[key];
				const vao = node.mesh.vao;
				gl.bindVertexArray(vao);
				gl.uniformMatrix4fv(material.shader.u_modelMat, false, node.getGLMatrix());
				gl.uniformMatrix4fv(material.shader.u_viewMat, false, defaultCamera.getGLMatrix());
				gl.uniformMatrix4fv(material.shader.u_projectMat, false, defaultCamera.projectMatrix);
				
				gl.enable(gl.DEPTH_TEST);
				gl.drawArrays(gl.TRIANGLES, 0, node.mesh.getCount());
				
			}
		}
		
		const defaultCamera = vic.webgl.engine.defaultCamera;
		const defaultLight = vic.webgl.engine.defaultLight;
		
		gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);
		gl.clearColor(0, 0, 0, 0);
		gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
		
		const cameraForce = vic.webgl.engine.extra.cameraForce;
		
		cameraForce.totalForce[0] = cameraForce.totalForce[1] = cameraForce.totalForce[2] = 0;
		cameraForce.totalForce.add( cameraForce.upForce ).add( cameraForce.downForce ).add(cameraForce.leftForce).add(cameraForce.rightForce).add(cameraForce.forwardForce).add(cameraForce.backwardForce);
		defaultCamera.applyForce(cameraForce.totalForce);
		defaultCamera.update();
		
		// 每一個材質都有自己的參數要設定
		// 1：取出要用哪一個shader(program)
		// 2：取出對應的vao
		// 3：放入這個shader需要的參數給buffer
		// 4：draw
		
		gl.enable(gl.DEPTH_TEST);
		const materials = vic.webgl.engine.materials;
		for( let matId = 0; matId < materials.length; ++matId ){
			const material = materials[matId];
			renderMaterial(material);
		}
		
		gl.disable(gl.DEPTH_TEST);
		renderMaterial(vic.webgl.engine.uiMaterial);
	}
	
	function setting(gl){
		//==========================
		// 初始化基本物件
		//==========================
		
		//gl.enable(gl.CULL_FACE);
		//gl.enable(gl.DEPTH_TEST);
		//gl.enable(gl.BLEND)
		//gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);
		
		vic.webgl.engine.gl = gl;
		
		// 朝-z軸看
		vic.webgl.engine.defaultCamera = new vic.webgl.mesh.DefaultNode();
		vic.webgl.engine.defaultCamera.projectMatrix = getProjection(40, gl.canvas.clientWidth / gl.canvas.clientHeight, 1, 100);
		vic.webgl.engine.defaultCamera.pos[1] = 5;
		vic.webgl.engine.defaultCamera.pos[2] = 20;
		
		vic.webgl.engine.defaultLight = new vic.webgl.mesh.DefaultNode();
		vic.webgl.engine.defaultLight.pos[0] = 5;
		vic.webgl.engine.defaultLight.pos[1] = 5;
		vic.webgl.engine.defaultLight.pos[2] = 5;
		
		const Material = vic.webgl.shader.Material;
		const ColorShader = vic.webgl.shader.ColorShader;
		const uiMaterial = new Material(new ColorShader());
		uiMaterial.pushUniform('uniform3fv', 'u_color', [1,0,0]);
		vic.webgl.engine.uiMaterial = uiMaterial;
		
		//==========================
		// 控制鏡頭
		//==========================
		
		let upForce = new Vector();
		let leftForce = new Vector();
		let downForce = new Vector();
		let rightForce = new Vector();
		let forwardForce = new Vector();
		let backwardForce = new Vector();
		let totalForce = new Vector();
		
		vic.webgl.engine.extra.cameraForce = {
			upForce:upForce,
			leftForce:leftForce,
			downForce:downForce,
			rightForce:rightForce,
			forwardForce:forwardForce,
			backwardForce:backwardForce,
			totalForce:totalForce
		};
		
		const defaultCamera = vic.webgl.engine.defaultCamera;
		let f;
		document.addEventListener('keydown', function(event) {
			if(!isMouseDown) return;
			switch(event.keyCode){
				// Q
				case 81:
					f = defaultCamera.getDown().mul(.1);
					downForce[0] = f[0];
					downForce[1] = f[1];
					downForce[2] = f[2];
				break;
				// E
				case 69:
					f = defaultCamera.getUp().mul(.1);
					upForce[0] = f[0];
					upForce[1] = f[1];
					upForce[2] = f[2];
				break;
				// W
				case 87:
					f = defaultCamera.getLeft().mul(.1);
					forwardForce[0] = f[0];
					forwardForce[1] = f[1];
					forwardForce[2] = f[2];
				break;
				// A
				case 65:
					f = defaultCamera.getBackward().mul(.1);
					leftForce[0] = f[0];
					leftForce[1] = f[1];
					leftForce[2] = f[2];
				break;
				// S
				case 83:
					f = defaultCamera.getRight().mul(.1);
					backwardForce[0] = f[0];
					backwardForce[1] = f[1];
					backwardForce[2] = f[2];
				break;
				// D
				case 68:
					f = defaultCamera.getForward().mul(.1);
					rightForce[0] = f[0];
					rightForce[1] = f[1];
					rightForce[2] = f[2];
				break;
			}
		});
		
		document.addEventListener('keyup', function(event) {
			//console.log(event.keyCode);
			switch(event.keyCode){
				// Q
				case 81:
					downForce[0] = downForce[1] = downForce[2] = 0;
				break;
				// E
				case 69:
					upForce[0] = upForce[1] = upForce[2] = 0;
				break;
				// W
				case 87:
					forwardForce[0] = forwardForce[1] = forwardForce[2] = 0;
				break;
				// A
				case 65:
					leftForce[0] = leftForce[1] = leftForce[2] = 0;
				break;
				// S
				case 83:
					backwardForce[0] = backwardForce[1] = backwardForce[2] = 0;
				break;
				// D
				case 68:
					rightForce[0] = rightForce[1] = rightForce[2] = 0;
				break;
			}
		});
		
		const clickPos = new Vector();
		let currentRot = new Vector();
		let isMouseDown = false;
		document.addEventListener('mousedown', (event)=>{
			switch(event.button){
				case 0:
					currentRot = defaultCamera.rot.clone();
					
					clickPos[0] = event.offsetX;
					clickPos[1] = event.offsetY;
					isMouseDown = true;
				break;
			}
			
		});
		
		const rotForce = new Vector();
		document.addEventListener('mousemove', (event)=>{
			if(isMouseDown){
				switch(event.button){
					case 0:
						const xOffset = event.offsetX - clickPos[0];
						const yOffset = event.offsetY - clickPos[1];
						rotForce[0] = yOffset * .1;
						rotForce[1] = xOffset * .1;
						
						rotForce.add(currentRot);
						defaultCamera.rot = rotForce.clone();
					break;
				}
			}
		});
		
		document.addEventListener('mouseup', (event)=>{
			switch(event.button){
				case 0: 
					isMouseDown = false;
					rotForce[0] = rotForce[1] = rotForce[2] = 0;
				break;
			}
			
		});
	}
	
	vic.webgl.engine.setting = setting;
    vic.webgl.engine.loadAssets = loadAssets;
	vic.webgl.engine.addNode = addNode;
	vic.webgl.engine.addMaterial = addMaterial;
	vic.webgl.engine.setMaterials = setMaterials;
	vic.webgl.engine.getNodes = getNodes;
	vic.webgl.engine.render = render;
	vic.webgl.engine.extra = {};
})();